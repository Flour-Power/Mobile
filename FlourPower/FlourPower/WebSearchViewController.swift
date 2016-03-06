//
//  WebSearchViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/24/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class WebSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    var search_terms = String?()
    var category: String?
    var data : [String] = []
    var filteredData: [String]!
    var recipes: [Recipe] = []
    var searchController: UISearchController!
    var searchResults = [String]()
    var searchActive : Bool = false
    var type = String?()
    
    
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: "dismissKeyboard")
        return recognizer
    }()


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
        webSearchTV.tableHeaderView = searchController.searchBar

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        
    }

    func dismissKeyboard() {
        
        webSearchBar.resignFirstResponder()
    }
    
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let recipe = recipes[indexPath.row]
        
        cell.textLabel?.text = recipe.recipeTitle
        
        return cell

    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        recipes.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (recipes as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredData = array as! [String]
        
        self.webSearchTV.reloadData()
    
    }
   


    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
        webSearchBar.text = ""
        webSearchTV.reloadData()
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
 

}






