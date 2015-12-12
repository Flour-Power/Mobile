//
//  FPCollectionViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//
    
    import UIKit
    
    private let _rr = RailsRequest()
    
    private let _d = NSUserDefaults.standardUserDefaults()
    
    class RailsRequest: NSObject {
        
        class func session() -> RailsRequest { return _rr }
        
        var token: String? {
            
            get { return _d.objectForKey("token") as? String }
            set { _d.setObject(newValue, forKey: "token") }
            
        }
        //will need out own server info
        private let APIbaseURL = "https://flour-power.herokuapp.com"
        
        func loginWithEmail(email: String, andPassword password: String, completion: () -> ()) {
            
            var info = RequestInfo()
            
            info.endpoint = "/users"
            
            info.method = .POST
            
            info.parameters = [
                
                "email" : email,
                "password" : password
                
            ]
            
            requiredWithInfo(info) { (returnedInfo) -> () in
                
                if let key = returnedInfo?["auth_token"] as? String {
                    
                    self.token = key
                    
                    print(self.token)
                    
                }
                
                if let errors = returnedInfo?["errors"] as? [String] {
                    //loops through errors
                }
                
                completion()
                
            }
            
        }
        
        func registerWithEmail(email: String, andPassword password: String, completion: () -> ()) {
            
            var info = RequestInfo()
            
            info.endpoint = "/users/new"
            
            info.method = .POST
            
            info.parameters = [
                
                
                "password" : password,
                "email" : email
                
            ]
            
            requiredWithInfo(info) { (returnedInfo) -> () in
                
                if let key = returnedInfo?["auth_token"] as? String {
                    
                    self.token = key
                    
                    print(self.token)
                    
                }
                
                if let errors = returnedInfo?["errors"] as? [String] {
                    //loops through errors
                }
                
                completion()
                
            }
            
        }
        
        
        func requiredWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
            
            let fullURLString = APIbaseURL + info.endpoint
            
//            print(fullURLString)
            
            guard let url = NSURL(string: fullURLString) else { return } //add run completion with fail
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info.method.rawValue
            
            
            
            //add token if we have one
            
            if let token = token {
                
                request.setValue(token, forHTTPHeaderField: "auth-token")
                
//                print(token)
                
            }
            
            if info.parameters.count > 0 {
                
                if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
                    
                    if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                        
                        request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                        
                        //possibly remove this line
                        let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                        
                        request.HTTPBody = postData
                        
                    }
                    
                }
                
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //here we grab the access token & user id
            
            
            
            // add parameters to body
            
            //creates a task from request
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    
//                    print(data)
//                    print(error)
                    
                    //work with the data returned
                    if let data = data {
                        
                        //have data
                        if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                            
                            completion(returnedInfo: returnedInfo)
                            
                        }
                        
                    } else {
                        
                        //no data: check if error is not nil
                        
                    }
                    
                    
                })
                
            }
            
            //runs the task (aka: makes the request call)
            task.resume()
        }
        
        
    }
    
    struct RequestInfo {
        
        enum MethodType: String {
            
            case POST, GET, DELETE
        }
        
        var endpoint: String!
        var method: MethodType = .GET
        var parameters: [String:AnyObject] = [:]
        
    }
    
    
    
    //RailsRequest.session()
    
