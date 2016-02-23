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
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    

        configureSearchController()
    
}
    


    func dismissKeyboard() {
    appSearchBar.resignFirstResponder()
}

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
}


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    
    cell.textLabel?.text = searchResults[indexPath.row]
    
    return cell
    
}




    func updateSearchResultsForSearchController(searchController: UISearchController)
{
    searchResults.removeAll()
    
    dispatch_async(dispatch_get_main_queue()) {
        self.searchRecipesTVC.reloadData()
        self.searchRecipesTVC.setContentOffset(CGPointZero, animated: false)
    }
    
}


    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        searchRecipesTVC.reloadData()
}

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
        searchRecipesTVC.reloadData()
}

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
        appSearchBar.text = ""
        searchRecipesTVC.reloadData()
}


    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
        var searchText = searchBar.text ?? ""
    
    
    
    dispatch_async(dispatch_get_main_queue()) {
        self.searchRecipesTVC.reloadData()
        self.dismissKeyboard()
        
        }
    }
}









