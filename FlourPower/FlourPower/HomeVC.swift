//
//  HomeViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var category0: UIButton!
    @IBOutlet weak var category1: UIButton!
    @IBOutlet weak var category2: UIButton!
    @IBOutlet weak var category3: UIButton!
    @IBOutlet weak var category4: UIButton!
    @IBOutlet weak var category5: UIButton!
    
    
    @IBAction func categoryButton(sender: UIButton) {
    
        let recipesVC = storyboard?.instantiateViewControllerWithIdentifier("RecipesVC") as? RecipesCollectionVC
        
        // set the category that we chose
        
        recipesVC?.category = sender.titleLabel?.text
        recipesVC?.categoryID = sender.tag
        
        // set categoryID based on tag
        
        navigationController?.pushViewController(recipesVC!, animated: true)
        
    }
    
    @IBOutlet weak var staticImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var info = RequestInfo()
        
        info.endpoint = "/categories"
        info.method = .GET
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let categories = returnedInfo?["categories"] as? [[String:AnyObject]] {
                
                print(categories)
                
                // per button tag = categories[0]["id"] as? Int ?? 0
                
                self.category0.tag = categories[0]["id"] as? Int ?? 0
                self.category1.tag = categories[1]["id"] as? Int ?? 0
                self.category2.tag = categories[2]["id"] as? Int ?? 0
                self.category3.tag = categories[3]["id"] as? Int ?? 0
                self.category4.tag = categories[4]["id"] as? Int ?? 0
                self.category5.tag = categories[5]["id"] as? Int ?? 0
                
                self.category0.setTitle(categories[0]["name"] as? String ?? "", forState: .Normal)
                self.category1.setTitle(categories[1]["name"] as? String ?? "", forState: .Normal)
                self.category2.setTitle(categories[2]["name"] as? String ?? "", forState: .Normal)
                self.category3.setTitle(categories[3]["name"] as? String ?? "", forState: .Normal)
                self.category4.setTitle(categories[4]["name"] as? String ?? "", forState: .Normal)
                self.category5.setTitle(categories[5]["name"] as? String ?? "", forState: .Normal)
                
            }
            
        }
        
    }
    
}
