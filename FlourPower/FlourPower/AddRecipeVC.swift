//
//  AddRecipeViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/4/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit

class AddRecipeVC: UIViewController {

    @IBOutlet weak var searchRecipe: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func searchRecipeSearchButtonClicked(searchRecipe: UISearchBar) {
        
        let searchText = searchRecipe.text ?? ""

        
        
        searchRecipe.resignFirstResponder()
        
    }
    
    let requestManager = RailsRequest()
    
    func searchForRecipe(named: String, completion: () -> ()) {

        
    }


}
