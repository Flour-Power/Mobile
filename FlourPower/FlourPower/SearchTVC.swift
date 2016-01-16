//
//  SearchTableViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/8/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit


class SearchTVC: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {

    @IBOutlet weak var SFPSearchBar: UISearchBar!
    @IBOutlet var SFTableview: UITableView!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchActive : Bool = false
    var data: [[Dictionary]]
    var filtered:[[Dictionary]]
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.data += [[Dictionary()]]
        self.filtered += [[Dictionary()]]
        self.SFTableview.reloadData()
        
        tableView.delegate = self
        tableView.dataSource = self
        SFPSearchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchRecipeSearchButtonClicked(searchRecipe: UISearchBar) {
        
        let searchText = searchRecipe.text ?? ""
        
        
        searchRecipe.resignFirstResponder()
        
    }
    
    let requestManager = RailsRequest()
    
    func searchForRecipe(named: String, completion: () -> ()) {
        
        tableView.reloadData()
        
    }

    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
   
        
    }
        
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.active {
            
              return self.filtered.count
        
            
        } else {
    
    
            return self.data.count
    

        }

    }

    
    override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell?
        
        if self.searchController.active {
            
            cell!.textLabel?.text = self.filtered[indexPath.row] as? String
          
        }
    }
    
}