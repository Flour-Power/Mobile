//
//  WebSearchTableViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 3/6/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class WebSearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    var search_terms = String?()
    var category: String?
    var data : [String] = []
    var recipes: [Recipe] = []
    var searchController: UISearchController!
    var searchResults = [String]()
    var searchActive : Bool = false
    var type = String?()
    var categoryID: Int?


   
    @IBAction func backButtonItem(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBOutlet weak var webSearchBar: UISearchBar!
    @IBOutlet weak var webSearchTV: UITableView!
    
    @IBOutlet weak var bbItem: UIBarButtonItem!
    @IBOutlet weak var imageLogo: UIButton!
    
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
    
    

    
    func dismissKeyboard() {
        
        webSearchBar.resignFirstResponder()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! WebCell
        
        let recipe = recipes[indexPath.row]
        
        print(recipe.recipeTitle)
        
        cell.recipeInfo = recipe
        
        cell.webTitleLabel?.text = recipe.recipeTitle
        
        cell.webView?.image = recipe.recipeSourceImage ?? recipe.getImage()
        
        cell.webView?.contentMode = .ScaleAspectFill
        
        
        return cell
        
    }
    


    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        searchActive = true
        webSearchBar.text = ""
        
        self.webSearchTV.reloadData()
        
     
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
        webSearchBar.text = ""
        self.tableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        recipes = []
        
        let searchText = webSearchBar.text ?? ""
        
        var info = RequestInfo()
        info.endpoint = "/api/recipes/search?query=\(searchText)"
        info.method = .GET
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                }
            }
            
            self.webSearchTV.reloadData()
            
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.dismissKeyboard()
            
        }
   
        
    }
    
 
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let recipe = recipes[indexPath.row]
        
        
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as? RecipeDetailVC
        
        
        detailVC?.recipe = recipe
        
        
        navigationController?.pushViewController(detailVC!, animated: true)
        
        
    }

}


