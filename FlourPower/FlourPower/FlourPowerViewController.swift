//
//  FlourPowerViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

import Foundation

class FlourPowerViewController: UIViewController, UIWebViewDelegate {
    
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func pressedLogin(sender: AnyObject) {
        
        //is password field blank?
        guard let password = passwordField.text else { return }
        //is username field blank?
        guard let email = emailField.text else { return }
        //if they aren't empty
        
        print("logged in pressed")
        
        RailsRequest.session().loginWithEmail(email, andPassword: password, completion: {
            
            print("logged in finished")
            
            
        })
        
        
    }
    
    
    @IBAction func pressedRegister(sender: AnyObject) {
        
        guard let password = passwordField.text else { return }
        
        guard let email = emailField.text else { return }
        
        print("registered pressed")
        
        
        //send request to server to create registration
        
        RailsRequest.session().registerWithEmail(email, andPassword: password, completion: {
            
            print("registered finished")
            
        
            
        })
        
        
    }
    
}
