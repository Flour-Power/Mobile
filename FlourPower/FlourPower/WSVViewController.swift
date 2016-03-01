//
//  WSVViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 3/1/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class WSVViewController: UIViewController {

    var category: String?
    var recipes: [Recipe] = []
    var recipe: Recipe!
    var categoryID: Int?
    
    @IBOutlet weak var wView: UIWebView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        var info = RequestInfo()
        info.endpoint = "/api/recipes/\(categoryID ?? 0)"
        info.method = .GET
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                }
            }
            
            self.wView.reload()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
