//
//  SFPTableViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/13/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit


public let ingredient = String()
public var type = String()


class SFPTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
<<<<<<< HEAD
    

    
    var search_terms = String?()
    var category: String?
    var data = [String]()
//    var filteredData = [MyRecipe]()
//    var recipesData = [MyRecipe]()
    var recipes : [Recipe] = []
    var searchController: UISearchController!
    var searchResults = [String]()
    var searchActive : Bool = false
<<<<<<< Updated upstream
    var type = String?()
=======



    

=======
    
    
    var search_terms = String?()
    var category: String?
    var data : [String] = []
    var filteredData: [String]!
    var recipes: [Recipe] = []
    var searchController: UISearchController!
    var searchResults = [String]()
    var searchActive : Bool = false
    var type = String?()
    
<<<<<<< Updated upstream
=======
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: "dismissKeyboard")
        return recognizer
    }()
    
>>>>>>> origin/master
>>>>>>> Stashed changes
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: "dismissKeyboard")
        return recognizer
    }()
    
>>>>>>> origin/master
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: "dismissKeyboard")
        return recognizer
    }()
    
>>>>>>> Stashed changes
    
  
    @IBOutlet weak var itemBackButton: UIBarButtonItem!
    
    @IBAction func bButton(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBOutlet weak var sLogo: UIButton!
    @IBOutlet weak var appSearchBar: UISearchBar!
    
    func configureSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
//    struct MyRecipe {
//        
//        var myRecipeTitle: String?
//        var myRecipeSource: String?
//        var myIngredients: [[String:AnyObject]] = []
//
//    }
    
    func dismissKeyboard() {
        appSearchBar.resignFirstResponder()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return recipes.count
    }
    
    
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let recipe = recipes[indexPath.row]
        
        print(recipe.recipeTitle)
        
        cell.textLabel?.text = recipe.recipeTitle
>>>>>>> Stashed changes

=======
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let recipe = recipes[indexPath.row]
        
        print(recipe.recipeTitle)
        
        cell.textLabel?.text = recipe.recipeTitle

<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
=======
>>>>>>> origin/master
        return cell
>>>>>>> Stashed changes
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyCell
        
        let recipe = recipes[indexPath.row]
        
        print(recipe.recipeTitle)
        
        cell.recipeInfo = recipe

        cell.myLabel?.text = recipe.recipeTitle
        
        cell.MyImage?.image = recipe.recipeSourceImage ?? recipe.getImage()
        
        cell.MyImage?.contentMode = .ScaleAspectFill

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        self.tableView.reloadData()
    }



>>>>>>> origin/master
        return cell
    
    }




    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchActive = true
      
        
    }

<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
<<<<<<< HEAD
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(searchActive) {
//            return recipes.count
//        }
    
>>>>>>> Stashed changes

=======
>>>>>>> origin/master
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
        appSearchBar.text = ""
        self.tableView.reloadData()

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(searchActive) {
//            return recipes.count
//        }
//        return data.count
//
//    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        recipes = []
        
        let searchText = appSearchBar.text ?? ""
        
        var info = RequestInfo()
        
        info.endpoint = "/recipes/search?name=\(searchText)"
        
        info.method = .GET
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            //            print(returnedInfo)
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                    
                }
                
            }
            self.tableView.reloadData()
        }
        
        dispatch_async(dispatch_get_main_queue()) {

            self.dismissKeyboard()
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let recipe = recipes[indexPath.row]
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as? RecipeDetailVC
        
        
        detailVC?.recipe = recipe
        
        
        navigationController?.pushViewController(detailVC!, animated: true)
        
        }
    
    }


}






