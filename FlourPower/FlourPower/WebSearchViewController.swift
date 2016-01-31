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

    var dataTask: NSURLSessionDataTask?
    
    var searchController: UISearchController!
    
    var searchResults = [String]()
    
    var searchActive : Bool = false
    var data = [""]
    var filtered:[String] = []
    var shouldShowSearchResults = false
  
  
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
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
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
        shouldShowSearchResults = true
        webSearchTV.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        webSearchTV.reloadData()
    }

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        dismissKeyboard()
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            webSearchTV.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        

        let APIbaseURL = "https://flour-power.herokuapp.com"
        
        var info = RequestInfo()
        info.endpoint = "/api/recipes/search?query=:search_terms"
        info.method = .GET
       
        func requiredWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
            
            let fullURLString = APIbaseURL + info.endpoint
            
            guard let url = NSURL(string: fullURLString) else { return }
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info.method.rawValue
            
            dataTask = defaultSession.dataTaskWithURL(url) {
                data, response, error in
             
                dispatch_async(dispatch_get_main_queue()) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        self.updateSearchResults(data)
                    }
                }
                
                self.dataTask?.resume()
        }
        
        }
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.webSearchTV.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
     
        filtered = data.filter({ (RailsRequest) -> Bool in
            let searchText: NSString = String()
            
            return (searchText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
      
        webSearchTV.reloadData()
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = webSearchTV.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if shouldShowSearchResults {
            
            cell.textLabel?.text = filtered[indexPath.row]
            
        } else {
            
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
    
}

