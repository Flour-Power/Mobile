//
//  HomeViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var category0: UIButton!
    
    @IBOutlet weak var category1: UIButton!
    
    @IBOutlet weak var category2: UIButton!
    
    @IBOutlet weak var category3: UIButton!
    
    @IBOutlet weak var category4: UIButton!
    
    @IBOutlet weak var category5: UIButton!
    
    
    @IBAction func categoryButton(sender: AnyObject) {
    
    
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var info = RequestInfo()
        
        info.endpoint = "/categories"
        info.method = .GET
        
        
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let categories = returnedInfo?["categories"] as? [[String:AnyObject]] {
                
                print(categories)
            
                self.category0.setTitle("/categories[0]", forState: .Normal)
                self.category1.setTitle("/categories[1]", forState: .Normal)
                self.category2.setTitle("/categories[2]", forState: .Normal)
                self.category3.setTitle("/categories[3]", forState: .Normal)
                self.category4.setTitle("/categories[4]", forState: .Normal)
                self.category5.setTitle("/categories[5]", forState: .Normal)
                
            }
            
        }
        
    }
    
}
