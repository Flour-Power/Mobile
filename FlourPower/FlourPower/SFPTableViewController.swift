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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    func configureSearchController() {
        
        searchRecipesTVC.delegate = self
        searchRecipesTVC.dataSource = self
        appSearchBar.delegate = self
        self.definesPresentationContext = true
        
        
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









