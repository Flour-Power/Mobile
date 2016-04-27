////
////  AddCollectionViewController.swift
////  FlourPower
////
////  Created by Kelly Robinson on 4/12/16.
////  Copyright © 2016 Kelly Robinson. All rights reserved.
////
//
//import UIKit
//
//private let reuseIdentifier = "addCell"
//
//class AddCollectionViewController: UICollectionViewController {
//    
//    var recipes: [Recipe] = []
//  
//    var category: String?
//    var categoryID: Int?
//
//
//    
//    @IBOutlet weak var sButton: UIBarButtonItem!
//    
//    @IBAction func saveButton(sender: UIBarButtonItem) {
//       
//        recipes = []
//        
//        dismissViewControllerAnimated(true, completion: nil)
//
//    }
//    
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//      
//        
//      
//        
//    }
//
//
//    func createRecipe(name: String, andCategory_names category_names: [String], andSteps steps: [String], andIngredients ingredients: [String], completion: () -> ()) {
//        
//        recipes = []
//        
//        var info = RequestInfo()
//        
//        info.endpoint = "/recipes"
//        info.method = .POST
//        info.parameters = [
//            
//            "name" : name,
//            "category_names" : category_names,
//            "steps" : steps,
//            "ingredients" : ingredients
//            
//        ]
//        
//        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
//            
//            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
//                
//                for recipeInfo in recipeInfos {
//                    
//                    let recipe = Recipe(info: recipeInfo, category: self.category)
//                    
//                    self.recipes.append(recipe)
//                    
//                    
//                }
//                
//            }
//            
//            self.collectionView?.reloadData()
//            
//        }
//    }
//
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        
//        return 1
//    }
//
//
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return recipes.count
//    }
//
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("addCell", forIndexPath: indexPath) as! AddCell
//        
//        
//        let recipe = recipes[indexPath.item]
//        
//        cell.recipeInfo = recipe
//        
//        cell.addImageView.image = recipe.recipeSourceImage ?? recipe.getImage()
//        
//        cell.addImageView.contentMode = .ScaleAspectFill
//        
//        cell.addRecipeNameTextField.text = recipe.recipeTitle
//        
//        
//        return cell
//    }
//
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//        let recipe = recipes[indexPath.item]
//        
//        let rcv = storyboard?.instantiateViewControllerWithIdentifier("RecipesVC") as? RecipesCollectionVC
//        
//        rcv?.recipe = recipe
//        
//        navigationController?.pushViewController(rcv!, animated: true)
//    }
//
//}
