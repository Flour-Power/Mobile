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
    
    var searchActive : Bool = false
    var recipes : [Recipe] = []
    var searchResults: [String] = []
    var category: String?
    var categoryID: Int?
    var searchController : UISearchController!
    var sesarch_terms = String()

    

    
    @IBOutlet weak var itemBackButton: UIBarButtonItem!
    
    @IBAction func bButton(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil) 
            
        }
    
    @IBOutlet weak var sLogo: UIButton!
    @IBOutlet weak var appSearchBar: UISearchBar!
    @IBOutlet var searchRecipesTVC: UITableView!

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchRecipesTVC.delegate = self
        searchRecipesTVC.dataSource = self
        appSearchBar.delegate = self
        self.definesPresentationContext = true
        
        
    }
    
    func searchByIngredient() {
        var info = RequestInfo()
                info.endpoint = "recipes/search?ingredients\(ingredient)\(type)"
                info.method = .GET
//                info.parameters = [
//        
//                "ingredient" : ingredient,
//                    "type" : type
//        
//               ]
        
                RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
        
                    if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
        
                        for recipeInfo in recipeInfos {
        
                            let recipe = Recipe(info: recipeInfo, category: self.category)
        
                            self.recipes.append(recipe)
                }
                      
            }
                   
        }
        
    }
    
    func searchByName() {
        
        var info = RequestInfo()
                info.endpoint = "/recipes/search?name\(sesarch_terms)"
                info.method = .GET
                info.parameters = [
        
                    "sesarch_terms" : sesarch_terms
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchByIngredient()
        searchByName()
        configureSearchController()
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            
            return searchResults.count
            
        } else {
            
            return recipes.count
        
        }
            
    }
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = searchRecipesTVC.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        if searchActive {
            
            cell.textLabel?.text = searchResults[indexPath.row]
            
        }
        
            return cell
        
        }


    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !searchActive {
        
            searchActive = true
            searchRecipesTVC.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }

    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        searchRecipesTVC.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        searchRecipesTVC.reloadData()
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
     
     
        searchRecipesTVC.reloadData()
    }


}





