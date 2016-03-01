//
//  SFPTableViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/13/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

public let ingredient = String!()
public var type = String()


class SFPTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    
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
    
    
    
    func dismissKeyboard() {
        appSearchBar.resignFirstResponder()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return recipes.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let recipe = recipes[indexPath.row]
        
        print(recipe.recipeTitle)
        
        cell.textLabel?.text = recipe.recipeTitle

        return cell
    
    }

    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//                return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//            })
//            
//            tableView.reloadData()
//        }
//    }

    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredData.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (recipes as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredData = array as! [String]
        
        self.tableView.reloadData()
        
    }

    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
        appSearchBar.text = ""
        self.tableView.reloadData()
    }
    
    
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
    
}









