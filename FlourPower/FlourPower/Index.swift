//
//  Index.swift
//  FlourPower
//
//  Created by Kelly Robinson on 2/6/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit
import Foundation



public class Indexing : NSObject {

    
    public let indexName: String = ""
    private let urlEncodedIndexName: String = ""
    private var searchCache: ExpiringCache?
    var recipeSourceURL: String?
    var recipeSourceImageURL: String?
    let ingredient = String!()
    var type = String()
    var recipes: [Recipe] = []
    var sesarch_terms = String()
    var search_terms = String()
    var id = Int()
    var category: String?
    var categoryID: Int?
    
    
    public func searchAPI(objectID: String, block: CompletionHandler? = nil) {
        
        var info = RequestInfo()
        info.endpoint = "/api/recipes/search?query\(search_terms)"
        info.method = .GET
        info.parameters = [
            
            "search_terms" : search_terms,
                      
        ]
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                }
            }
        }
    }
    
    public func searchByIngredient(objectID: String, block: CompletionHandler? = nil) {
        
        var info = RequestInfo()
        info.endpoint = "recipes/search?ingredients\(ingredient)\(type)"
        info.method = .GET
//        info.parameters = [
//        
//        "ingredient" : ingredient,
//            "type" : type
//        
//       ]
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                }
              }
           }
        }
    
    public func searchByName(objectID: String, block: CompletionHandler? = nil) {
        
        var info = RequestInfo()
        info.endpoint = "/recipes/search?name\(sesarch_terms)"
        info.method = .GET
        info.parameters = [
            
            "sesarch_terms" : sesarch_terms
            
        ]
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                }
            }
        }
    }
    
    public func updateRecipe(objectID: String, block: CompletionHandler? = nil) {
        
        var info = RequestInfo()
        info.endpoint = "/recipes/\(id)"
        info.method = .PATCH
        info.parameters = [
            
            "id" : id
            
        ]
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                    
                    self.recipes.append(recipe)
                    
                }
            }
        }
    }
    
    public func deleteRecipe(objectID: String, block: CompletionHandler? = nil) {
        
        var info = RequestInfo()
        info.endpoint = "/recipes/\(id)"
        info.method = .DELETE
        info.parameters = [
            
            "id" : id
            
        ]
        
        RailsRequest.session().requiredWithInfo(info) { (returnedInfo) -> () in
            
            if let recipeInfos = returnedInfo?["recipes"] as? [[String:AnyObject]] {
                
                for recipeInfo in recipeInfos {
                    
                    let recipe = Recipe(info: recipeInfo, category: self.category)
                 
                    self.recipes.append(recipe)

                }
            }
        }
    }
    
}

