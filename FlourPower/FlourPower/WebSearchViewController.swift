//
//  WebSearchViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/24/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class WebSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

//    var dataTask: NSURLSessionDataTask?
    var searchResultsUpdater: UISearchResultsUpdating?

    
    var searchController: UISearchController!
    
    var searchResults = [String]()
    
    
    var searchActive : Bool = false
    var data: [String] = []
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
    func updateSearchResults(data: NSData?) {
        searchResults.removeAll()
      
            dispatch_async(dispatch_get_main_queue()) {
            self.webSearchTV.reloadData()
            self.webSearchTV.setContentOffset(CGPointZero, animated: false)
        }
    }
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredSearch.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (data as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredSearch = array as! [String]
        
        self.webSearchTV.reloadData()
    }

    
}

extension WebSearchViewController: UISearchBarDelegate {
 
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
        
        
        var info = RequestInfo()
        info.endpoint = "/api/recipes/search?query=:search_terms"
        info.method = .GET
       
        func requiredWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
            
            
          
            
        }
        
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
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
    
        if (self.searchController.active) {
            cell.textLabel?.text = filteredSearch[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = data[indexPath.row]
            
            return cell
        }
    
    }

}