//
//  FPCollectionViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/2/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RecipesCell"

typealias Dictionary = [String : AnyObject]


class FPCollectionViewController: UICollectionViewController, UISearchBarDelegate {

    var recipes: [Recipe] = []
    
    @IBAction func addRecipe(sender: AnyObject) {
        
    }
    
    @IBOutlet var recipeCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show recipes in specific category

    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recipes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipesCell", forIndexPath: indexPath) as! RecipeImageCollectionViewCell
        
        // setup cell
        
        let recipe = recipes[indexPath.item]
        
        
        cell.recipeInfo = recipe
        
        /// add back image
        
        cell.recipeImageView.image = recipe.recipeSourceImage ?? recipe.getImage()
        
        cell.titleLabel.text = recipe.recipeTitle
        
        return cell
        
    }
    
}


class Recipe: NSObject {
    
    var category: String?
    
    var recipeID: Int?
    var recipeTitle: String?
    
    var ingredients: [[String:AnyObject]] = []
    var directions: [String] = []
    
    var recipeSourceURL: String?
    var recipeSourceImageURL: String?
    var recipeSource: String?
    var recipeSourceImage: UIImage?
    
    init(info: Dictionary, category: String) {
        
        self.category = category
        
        recipeID = info["id"] as? Int
        recipeTitle = info["name"] as? String
        
        recipeSourceURL = info["source_url"] as? String
        recipeSourceImageURL = info["source_image_url"] as? String
        recipeSource = info["source_name"] as? String
        
        ingredients = info["ingredients"] as? [[String:AnyObject]] ?? []
        
        directions = info["directions"] as? [String] ?? []
        
    }
    
    func getImage() -> UIImage? {
        
        if let imageURL = NSURL(string: recipeSourceImageURL ?? "") {
            
            if let imageData = NSData(contentsOfURL: imageURL) {
                
                recipeSourceImage = UIImage(data: imageData)
                return UIImage(data: imageData)
                
            }
            
        }
        
        return nil
        
    }
    
    
}
