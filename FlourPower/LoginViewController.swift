//
//  LoginViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 11/30/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

private let EMPTY_STRING = ""
private let REGISTER_FAILED = "Register Failed"
private let LOGIN_FAILED = "Login Failed"
private let LOGIN_IS_EMPTY = "Login is Empty."
private let PASSWORD_IS_EMPTY = "Password is Empty"
private let WELCOMEVC = "WelcomeVC"
private let STORYBOARD_NAME = "FlourPower"
private let DESTINATION_VC = ""
private let ALERT = "Alert"
private let ALERT_MSG = "Incorret email or password"
private let OK = "Ok"
private let UNKNOWN_ERROR = "Unknown error"
private let INVALID_EMAIL = "Invalid email and/or password"

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    let userEmailRequest = RailsRequest.session()
    
    //MARK: - @IBOutlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var bottomTextFieldConstraint: NSLayoutConstraint!
    
    //MARK: - @IBActions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        guard let email = emailTextField.text where email != EMPTY_STRING else {
            return alertError(LOGIN_FAILED, reason: LOGIN_IS_EMPTY)}
        guard let password = passwordTextField.text where password != EMPTY_STRING else {
            return alertError(LOGIN_FAILED, reason: PASSWORD_IS_EMPTY)}
        
        RailsRequest.session().loginWithEmail(email, andPassword: password) { (success) -> () in
            
            if let token = RailsRequest.session().token {
                print("requested token: \(token)")
                if token == EMPTY_STRING {
                    self.alertError(LOGIN_FAILED, reason: INVALID_EMAIL)
                } else if let vc = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewControllerWithIdentifier(DESTINATION_VC) as? FlourPowerViewController {
                    print("email \(email)")
                    
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        guard let email = emailTextField.text where email != EMPTY_STRING else {
            return alertError(REGISTER_FAILED, reason: "Email is empty.") }
//        guard let username = usernameTextField.text where username != EMPTY_STRING else {
//            return alertError(REGISTER_FAILED, reason: "Username is empty.")}
        guard let password = passwordTextField.text where password != EMPTY_STRING else {
            return alertError(REGISTER_FAILED, reason: "Password is empty.")}
        
        RailsRequest.session().registerWithEmail(email, password: password) { (success) -> () in
            if let token = RailsRequest.session().token {
                print("requested token: \(token)")
//                if token == EMPTY_STRING {
//                    self.alertError(LOGIN_FAILED, reason: INVALID_USERNAME)
//                } else if let vc = UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewControllerWithIdentifier(DESTINATION_VC) as? CameraViewController {
//                    print("username \(username)")
//                    
//                    self.presentViewController(vc, animated: true, completion: nil)
//                    
//                }
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(animated: Bool) {
        emailTextField?.delegate = self
        passwordTextField?.delegate = self
        emailTextField?.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func alertError(title: String, reason:String) {
        
        let alertVC = UIAlertController(title: title, message: reason, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: { (action) -> Void in
            alertVC.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        self.bottomTextFieldConstraint.constant = 200
        UIView.animateWithDuration(0.50, animations: { () -> Void in
            self.view.layoutIfNeeded()
            
        })
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.layoutIfNeeded()
        textField.resignFirstResponder()
        
        UIView.animateWithDuration(0.50) { () -> Void in
            if self.bottomTextFieldConstraint.identifier == "Login" {
                self.bottomTextFieldConstraint.constant = 160
                self.view.layoutIfNeeded()
                
            } else {
                self.bottomTextFieldConstraint.constant = 80
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.layoutIfNeeded()
        textField.resignFirstResponder()
        
        UIView.animateWithDuration(0.50) { () -> Void in
            if self.bottomTextFieldConstraint.identifier == "Login" {
                self.bottomTextFieldConstraint.constant = 160
                self.view.layoutIfNeeded()
            } else {
                self.bottomTextFieldConstraint.constant = 60
                self.view.layoutIfNeeded()
                
            }
            
        }
        
        return true
    }
    
}
