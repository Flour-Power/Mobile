//
//  AddViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 4/26/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var recipes: [Recipe] = []
    
    
    @IBOutlet weak var lImage: PrettyButton!
    
    @IBOutlet weak var bButtonSave: UIBarButtonItem!
    
    @IBOutlet weak var logoSmall: UIButton!
    
    @IBOutlet weak var addImageView: UIImageView!
    
    @IBOutlet weak var rTitleText: UITextField!

    @IBOutlet weak var ingredientsText: UITextView!
    
    
    @IBOutlet weak var directionsText: UITextView!
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        recipes = []
        
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func uploadButton(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
