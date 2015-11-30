//
//  RailsRequest.swift
//  RR
//
//  Created by Kelly Robinson on 11/5/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

private let NAME = "name"
private let USER = "user"
private let USERNAME = "username"
private let PASSWORD = "password"
private let EMAIL = "email"
private let ERRORS = "errors"
private let INDEX = "index"
private let DECKS = "decks"
private let TITLE = "title"
private let ID = "id"

private let ACCESS_TOKEN = "access_token" // need to get


private let _rr = RailsRequest()
private let _d = NSUserDefaults.standardUserDefaults()
private let _default = NSUserDefaults.standardUserDefaults()


class RailsRequest: NSObject {

    class func session() -> RailsRequest { return _rr }
    /// The token captured after login/register used to make authenticated API calls.
    var token: String? {
        
        get { return _d.objectForKey("token") as? String }
        
        set { _d.setObject(newValue, forKey: "token") }
        
    }
    
    var currentPassword: String? {
        get { return _default.objectForKey(PASSWORD) as? String }
        set { _default.setObject(newValue, forKey: PASSWORD) }
        
    }
    
    var currentEmail: String? {
        get { return _default.objectForKey(EMAIL) as? String }
        set { _default.setObject(newValue, forKey: EMAIL) }
    }
    
   
    /// The base url used when making as API call
    private let baseUrl = "http://flour-power.herokuapp.com/"
    
    
    /**
     This method will try to login a user with the credentials below.
     
     - parameter username: The name used when reegistering.
     - parameter password: The password used when registering.
     */
    func loginWithEmail(email: String, andPassword password: String, success:Bool -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "users"
        info.method = .POST
        info.parameters = [
        
            "email" : email,
            "password" : password
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            // here we grab the access token & user id
            
            if let userEmail = returnedInfo?["email"] as? [String: AnyObject] {
                
                if let key = userEmail["access_key"] as? String {
                    
                    self.token = key
                    success(true)

                }
                
            }
            
            if let errors = returnedInfo?["errors"] as? [String] {
                
                // loop through errors
            }
            
        }
    }
    
    func registerWithEmail(email: String, password:String, success: (Bool) -> ()) {
        var info = RequestInfo()
        info.endpoint = "users/new"
        info.method = .POST
        info.parameters = [
           
            password : "password",
            email : "email"
            
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            if let user = returnedInfo?[USER] as? [String:AnyObject] {
                
                
                if let password = user[PASSWORD] as? String {
                    self.currentPassword = password
                }
                
                if let email = user[EMAIL] as? String {
                    self.currentEmail = email
                }
                
                if let key = user[ACCESS_TOKEN] as? String {
                    self.token = key
                    print(self.token)
                    success(true)
                    
                }
                
                if let error = returnedInfo?[ERRORS] as? [String] {
                    print(error)
                    success(false)
                    
                }
                
            }
            
        }
        
    }
    
    
    /**
     Makes a generic request to the API, configured by the info parameter.
     
     - parameter info:       Used to configure the API request.
     - parameter completion: A completion blck that may be called with an optional object.
        The object could be an Array or Dictionary, you must handle the type within the completion block.
     */
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        
        let fullURLString = baseUrl + info.endpoint
        
        guard let url = NSURL(string: fullURLString) else { return } // add run completion with fail
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.method.rawValue
        
        // add token if we have one
        
        if let token = token {
            
            request.setValue(token, forHTTPHeaderField: "Authorization")
            
        }
        
        // add parameters to body
        
        if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
            
            if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                
                request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                
                let postData =  jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                
                request.HTTPBody = postData
                
            }
            
        
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        // create a task from request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            // works with the data returned
            if let data = data {
                
                // have data
                if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                    
                    completion(returnedInfo: returnedInfo)
                    
                    
                }
                
            } else {
                
                // no data : check if error is not nil
                
            }
            
            }
        }
        
        // runs the task (aka : makes the request call)
    }
    
    


/**
 *  A type used to collect information to build an API call.
 */
struct RequestInfo {
    
    enum MethodType: String {
        
        case POST, GET, DELETE
        
    }
    
    
 /// The part of the url added to the base to make a specific API call.
    var endpoint: String!
    
 /// The method type (GET,POST,DELETE) used for modifyiing the API call.
    var method: MethodType = .GET
    
 /// Parameters that are required/optionaln to be added to the API call.
    var parameters: [String:AnyObject] = [:]
    
}