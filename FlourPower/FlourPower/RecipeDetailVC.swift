//
//  FPDetailTableViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 12/8/15.
//  Copyright © 2015 Kelly Robinson. All rights reserved.
//

import UIKit
import AVFoundation

class RecipeDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, AVSpeechSynthesizerDelegate {

    var recipe: Recipe!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    @IBOutlet weak var btnNextIngredient: UIButton!
    

    @IBOutlet weak var btnNextStep: UIButton!
    
    let speechSynthesizer = AVSpeechSynthesizer()

    var rate: Float!
    
    var pitch: Float!
    
    var volume: Float!
    
    var totalUtterances: Int! = 0
    
    var currentUtterance: Int! = 0
    
    var totalTextLength: Int = 0
    
    var spokenTextLengths: Int = 0
    
    override func viewDidAppear(animated: Bool) {
        
        if !loadSettings() {
            registerDefaultSettings()
        }
            speechSynthesizer.delegate = self
        
        print(recipe.recipeTitle)
        
        navigationItem.title = recipe.recipeTitle
        
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        
        recipeTableView.reloadData()
        
        
        
    }
    
    func registerDefaultSettings() {
        rate = AVSpeechUtteranceDefaultSpeechRate
        pitch = 1.0
        volume = 1.0
        
        let defaultSpeechSettings: [String:AnyObject] = ["rate": rate, "pitch": pitch, "volume": volume]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultSpeechSettings)
    }
    
    func loadSettings() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults() as NSUserDefaults
        
        if let theRate: Float = userDefaults.valueForKey("rate") as? Float {
            rate = theRate
            pitch = userDefaults.valueForKey("pitch") as! Float
            volume = userDefaults.valueForKey("volume") as! Float
            
            return true
        }
        
        return false
    }
    
    var currentIngredient = 0
    
    @IBAction func nextIngredientButton(sender: AnyObject) {
        
        if !speechSynthesizer.speaking {
            
            
            let ingredient = recipe.ingredients[currentIngredient]
            
            // create 3 variables
            
            let amount = ingredient["amount"] as? Int ?? 0
            let unit = ingredient["unit"] as? String ?? ""
            let name = ingredient["name"] as? String ?? ""
            
            let thingToSay = "\(amount) \(unit) \(name)"
            
            let speechUtterance = AVSpeechUtterance(string: thingToSay)
            speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = pitch
            speechUtterance.volume = volume
            
            speechSynthesizer.speakUtterance(speechUtterance)
            
            currentIngredient++
            
            if currentIngredient == recipe.ingredients.count { currentIngredient = 0 }
            
        }
        else{
            speechSynthesizer.continueSpeaking()
        }
        
    }
    
    var currentStep = 0
    
    @IBAction func nextStepButton(sender: AnyObject) {
        
            
            if !speechSynthesizer.speaking {
                
                
                let step = recipe.directions[currentStep]
                
                
                let speechUtterance = AVSpeechUtterance(string: step)
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitch
                speechUtterance.volume = volume
                
                speechSynthesizer.speakUtterance(speechUtterance)
                
                currentStep++
                
                if currentStep == recipe.directions.count { currentStep = 0 }
                
            }
            else{
                speechSynthesizer.continueSpeaking()
            }
            
        }
        
        
    
    
    // add actions for buttons to play stuff
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        
    }
    
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        
    }
    
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
        
    }
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // sections : 0 - Ingredients, 1 - Steps
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {
            
            print(recipe.ingredients.count)
            return recipe.ingredients.count
            
        } else {
            
            print(recipe.directions.count)
            return recipe.directions.count
        
        }
      
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // indexPath.section
        // change reuseID based on section
        
        
        
        // if section == 0 then set reuse identifier to ingredientCell else set reuse identifier to stepCell

        var reuseID = ""

        
        if indexPath.section == 0 {
            
            reuseID = "IngredientCell"
            
        } else {
            
            reuseID = "StepCell"
            
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath)

        if indexPath.section == 0 {
            
            let ingredient = recipe.ingredients[indexPath.row]
            
            // create 3 variables
            
            let amount = ingredient["amount"] as? Int ?? 0
            let unit = ingredient["unit"] as? String ?? ""
            let name = ingredient["name"] as? String ?? ""
            
            
            cell.textLabel?.text = "\(amount) \(unit) \(name)"
            
            
            
        } else {
            
            print(recipe.directions[indexPath.row])
            
            cell.textLabel?.text = recipe.directions[indexPath.row]
            
        }
        
        
        // Configure the cell...

        return cell
    }


}
