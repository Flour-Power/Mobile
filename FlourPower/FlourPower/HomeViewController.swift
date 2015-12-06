//
//  HomeViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    

    @IBAction func categoryButton(sender: AnyObject) {
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    
typealias categories = String
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
        // get categories
        
        var category = String()
        
        func getCategories(completion:([categories]) -> Void) {
            
            var info = RequestInfo()
            
            info.endpoint = "/categories"
            info.method = .GET
            
            
            
            RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
                
                
//                var _categories: [String] = []
//                if let categories = returnedInfo?["categories"] as? [[String:AnyObject]] {
//                    
//                    categories.map{$0["name"]}
//                    
//                    
//                }
                
            print(returnedInfo)
                
              //pass categories back in completion handler
              completion([""])
            }
        
        }
        
    

}
