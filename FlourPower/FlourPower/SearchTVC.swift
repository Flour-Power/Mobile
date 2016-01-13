////
////  SearchTableViewController.swift
////  FlourPower
////
////  Created by Kelly Robinson on 12/8/15.
////  Copyright © 2015 Kelly Robinson. All rights reserved.
////
//
//import UIKit
//
//
//class SearchTVC: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {
//
//    @IBOutlet weak var searchBarFP: UISearchBar!
//    
//    @IBOutlet weak var FPTableView: UITableView!
//    
//    
//    
//    let searchController = UISearchController(searchResultsController: nil)
//    
//    var searchActive : Bool = false
//    var data: [String] = []
//    var filtered:[Dictionary]
//    
// 
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        searchBarFP.delegate = self
//        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
//        
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    func searchRecipeSearchButtonClicked(searchRecipe: UISearchBar) {
//        
//        let searchText = searchRecipe.text ?? ""
//        
//        
//        searchRecipe.resignFirstResponder()
//        
//    }
//    
//    let requestManager = RailsRequest()
//    
//    func searchForRecipe(named: String, completion: () -> ()) {
//        
//        tableView.reloadData()
//        
//    }
//
//    
//    
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//   
//        
//    }
//        
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        
//    }
//    
//
//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//    
//
//
//
//}
//
