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


class SFPTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    var search_terms = String?()
    var category: String?
    var data: [String] = []
    var filteredData: [String] = []
    var recipes: [Recipe] = []
    var searchController: UISearchController!
    var searchResults = [String]()
    var searchActive : Bool = false
    //    var ingredients = String?()
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
//        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        configureSearchController()
        
    }
    
    
    
    func dismissKeyboard() {
        appSearchBar.resignFirstResponder()
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
        
//        if self.searchActive {
//            
//            
//            return cell
//            
//        } else {
//            
//            cell.textLabel?.text = filteredData[indexPath.row]
//            
//            return cell
//        }
//        
    }
    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        
//        searchResults.removeAll(keepCapacity: false)
//        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
//        let array = (data as NSArray).filteredArrayUsingPredicate(searchPredicate)
//        filteredData = array as! [String]
//        
//        dispatch_async(dispatch_get_main_queue()) {
//            self.tableView.setContentOffset(CGPointZero, animated: false)
//        }
//        
//        tableView.reloadData()
//        
//    }
    
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
        appSearchBar.text = ""
        tableView.reloadData()
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









