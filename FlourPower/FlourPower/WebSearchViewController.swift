//
//  WebSearchViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/24/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class WebSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

//    var dataTask: NSURLSessionDataTask?
    var searchResultsUpdater: UISearchResultsUpdating?

    
    var searchController: UISearchController!
    
    var searchResults = [String]()
    
    var data = Indexing()
    var results : [RailsRequest] = []
    var searchActive : Bool = false
    var filteredSearch = [String]()
    var search = [Dictionary]()
    

  
  
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
        webSearchTV.delegate = self
        webSearchTV.dataSource = self
        webSearchBar.delegate = self
        configureSearchController()
        webSearchTV.tableFooterView = UIView()

        data.searchAPI("") { (content, error) -> Void in
            
            self.webSearchTV.reloadData()
        }
    }

    func dismissKeyboard() {
        webSearchBar.resignFirstResponder()
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        

        
    }
//    func updateSearchResults(data: NSData?) {
//        searchResults.removeAll()
//      
//            dispatch_async(dispatch_get_main_queue()) {
//            self.webSearchTV.reloadData()
//            self.webSearchTV.setContentOffset(CGPointZero, animated: false)
//        }
//    }
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
     

    
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

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        dismissKeyboard()
        
        
        if(filteredSearch.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.webSearchTV.reloadData()
    }
   
  
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredSearch.count
        }
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
    
        if (self.searchController.active) {
            cell.textLabel?.text = filteredSearch[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = data.search_terms
            
            return cell
        }
    
    }

}