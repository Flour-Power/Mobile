//
//  WebSearchViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 1/24/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class WebSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

//    var dataTask: NSURLSessionDataTask?
    
    var searchController: UISearchController!
    
    var searchResults = [String]()
    
    var searchActive : Bool = false
    var data = [""]
    var filtered:[String] = []
  
  
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: "dismissKeyboard")
        return recognizer
    }()


    @IBOutlet weak var webSearchBar: UISearchBar!
    @IBOutlet weak var webSearchTV: UITableView!
    
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
//        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
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
  
    
  
}

extension WebSearchViewController: UISearchBarDelegate {
 
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        dismissKeyboard()
        
     
        
        let APIbaseURL = "https://flour-power.herokuapp.com"
        
        var info = RequestInfo()
        info.endpoint = "/api/recipes/search?query=:search_terms"
        info.method = .GET
       
        func requiredWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
            
            let fullURLString = APIbaseURL + info.endpoint
            
            guard let url = NSURL(string: fullURLString) else { return }
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info.method.rawValue
          
            
        }
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.webSearchTV.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = webSearchTV.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
        }
        
        return cell;
    }
    
}

