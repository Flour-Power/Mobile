
import UIKit

import Foundation

class LoginViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func pressedLogin(sender: AnyObject) {
        
        //is password field blank?
        guard let password = passwordField.text else { return }
        //is username field blank?
        guard let username = usernameField.text else { return }
        //if they aren't empty
        
        print("loged in pressed")
        
        RailsRequest.session().loginWithEmail(email , andPassword: password, completion: {
            
            print("loged in finished")
            
            let loginSB = UIStoryboard(name: "FlashCardStoryboard", bundle: nil)
            
            if let flashVC = loginSB.instantiateInitialViewController() {
                
                self.navigationController?.setViewControllers([flashVC], animated: true)
            }
            
        })
        
        
    }
    
    
    @IBAction func pressedRegister(sender: AnyObject) {
        
        guard let password = passwordField.text else { return }
        
        guard let username = usernameField.text else { return }
        
        guard let email = emailField.text else { return }
        
        print("registered pressed")
        
        
        //send request to server to create registration
        
        RailsRequest.session().registerWithUsername(username, andPassword: password, email: email, completion: {
            
            print("registered finished")
            
            
            
            let loginSB = UIStoryboard(name: "FlashCardStoryboard", bundle: nil)
            
            if let flashVC = loginSB.instantiateInitialViewController() {
                
                self.navigationController?.setViewControllers([flashVC], animated: true)
                
            }
            
        })
        
        
        
        
    }
    
}

