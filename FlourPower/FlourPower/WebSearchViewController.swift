//
//  WebSearchViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/24/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class WebSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    var search_terms = String()
    var category: String?
    var recipes: [Recipe] = []
    var searchController: UISearchController!
    var searchResults = [String]()
    var searchActive : Bool = false
  
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webSearchTV.dataSource = self
        configureSearchController()
        webSearchTV.tableFooterView = UIView()
        
        var info = RequestInfo()
        info.endpoint = "/api/recipes/search?query\(search_terms)"
        info.method = .GET
        info.parameters = [
            
            "search_terms" : search_terms,
            
        ]
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                }
            }
        }
        
    }

    func dismissKeyboard() {
        webSearchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = searchResults[indexPath.row]
        
        return cell

    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        

        
    }

    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        searchResults.removeAll()
        
                    dispatch_async(dispatch_get_main_queue()) {
                    self.webSearchTV.reloadData()
                    self.webSearchTV.setContentOffset(CGPointZero, animated: false)
                }
    
    }

 
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        webSearchTV.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
        webSearchTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
        webSearchBar.text = ""
        webSearchTV.reloadData()
    }

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        var searchText = searchBar.text ?? ""
        
        
        
        dispatch_async(dispatch_get_main_queue()) {
        self.webSearchTV.reloadData()
        self.dismissKeyboard()
        
        }
    }
}




