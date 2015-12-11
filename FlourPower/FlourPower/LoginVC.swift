//
//  FlourPowerViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

import Foundation

class LoginVC: UIViewController, UIWebViewDelegate, UITextFieldDelegate {
    
  
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func pressedLogin(sender: AnyObject) {
        
       
        guard let password = passwordField?.text else { return }
        guard let email = emailField.text else { return }
        //if they aren't empty
        
        print("logged in pressed")
        
        RailsRequest.session().loginWithEmail(email, andPassword: password, completion: {
            
            let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier("HomeVC")
            self.navigationController?.pushViewController(homeVC!, animated: true)
            
        })
            
    }
       
    
    
    @IBAction func pressedRegister(sender: AnyObject) {
        
        guard let password = passwordField?.text else { return }
        guard let email = emailField.text else { return }
        
        print("registered pressed")
        
        
        //send request to server to create registration
        
        RailsRequest.session().registerWithEmail(email, andPassword: password, completion: {
            
            let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier("HomeVC")
            self.navigationController?.pushViewController(homeVC!, animated: true)
            
        
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField?.delegate = self
        passwordField?.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:
            UIKeyboardWillShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        self.view.frame.origin.y = -210
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        
        self.view.frame.origin.y = 0
        
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }

}