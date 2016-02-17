//
//  SFPTableViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/13/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class SFPTableViewController: UITableViewController, UISearchBarDelegate {
    
    var searchActive : Bool = false
    var data = Indexing()
    var results : [RailsRequest] = []
    var category: String?
    var categoryID: Int?
    var filtered = [String]()
    

    
    @IBOutlet weak var itemBackButton: UIBarButtonItem!
    
    @IBAction func bButton(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil) 
            
        }
    
    @IBOutlet weak var sLogo: UIButton!
    @IBOutlet weak var appSearchBar: UISearchBar!
    @IBOutlet var searchRecipesTVC: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
      
        data.searchByIngredient("ingredient") { (content, error) -> Void in
            
            self.tableView.reloadData()
        }
        
        data.searchByName("name") { (content, error) -> Void in
            
            self.tableView.reloadData()
        }
        
    
       
    }
    
    private func configureSearchController() {
        
        searchRecipesTVC.delegate = self
        searchRecipesTVC.dataSource = self
        appSearchBar.delegate = self
        self.definesPresentationContext = true

    
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        let searchText = searchBar.text ?? ""
        
        data.searchByIngredient(searchText) { (content, error) -> Void in
            
            self.searchRecipesTVC.reloadData()
        }
        
        data.searchByName(searchText) { (content, error) -> Void in
            
            self.searchRecipesTVC.reloadData()
        }
        
    }

    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
     
        
        self.tableView.reloadData()
    }


  
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return results.count
    }
    
    func TV(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchRecipesTVC.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data.search_terms
        }
        
        return cell
        }
    

    }

