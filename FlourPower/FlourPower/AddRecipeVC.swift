//
//  AddRecipeViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/4/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class AddRecipeVC: UIViewController {

    @IBOutlet weak var searchRecipe: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
//        searchRecipe.delegate = self
//        
//        recipeData.searchForRecipe("Cheese Grits") { () -> () in
//            
//            self.recipesCollectionView.reloadData()
//            
//        }
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
    
    func searchRecipeSearchButtonClicked(searchRecipe: UISearchBar) {
        
        let searchText = searchRecipe.text ?? ""
        
//        recipeData.searchForRecipe(searchText) { () -> () in
//            
//            self.recipesCollectionView.reloadData()
//            
//        }
        
        
        searchRecipe.resignFirstResponder()
        
    }
    
    let requestManager = RailsRequest()
    
    func searchForRecipe(named: String, completion: () -> ()) {
        
//        Recipe = []
//        
//        let namedStripped = named.stringByReplacingOccurrencesOfString(" ", withString: "+")
//        
//        let urlString = "" + namedStripped + ""
//        
//        requestManager.GET(urlString, parameters: nil, success: { (operation, data) -> Void in
//            
//            if let foundInfo = data as? Dictionary {
//                
//                if let results = foundInfo["results"] as? [Dictionary] {
//                    
//                    for result in results {
//                        
//                        let recipe = Recipe(info: result)
//                        self.recipe.append(recipe)
//                        
//                    }
//                    
//                    completion()
//                    
//                }
//                
//            }
//            
//            //        print(data)
//            
//            }) { (operation, error) -> Void in
//                
//                print(error)
//                
//        }
        
    }


}
