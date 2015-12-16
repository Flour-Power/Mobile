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
    
    @IBOutlet weak var FImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var btnLast: UIButton!
    
    @IBOutlet weak var btnPause: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    @IBOutlet weak var btnNextIngredient: UIButton!
    
    @IBOutlet weak var nextStack: UIStackView!
    @IBOutlet weak var buttonStack: UIStackView!

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
        
        recipeImageView.image = recipe.recipeSourceImage ?? recipe.getImage()
      
        recipeImageView.contentMode = .ScaleAspectFill
        
    
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        
        recipeTableView.reloadData()
        
        btnNextIngredient.layer.cornerRadius = 25.0
        btnNextStep.layer.cornerRadius = 25.0
        btnLast.layer.cornerRadius = 25.0
        btnPause.layer.cornerRadius = 25.0
        btnStop.layer.cornerRadius = 25.0
        
        // Set the initial alpha value of the following buttons to zero (make them invisible).
//        btnPause.alpha = 0.0
//        btnStop.alpha = 0.0
//        btnLast.alpha = 0.0
        
        // Make the progress view invisible and set is initial progress to zero.
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        // tell it to shutup
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Word)

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
            
            speechUtterance = AVSpeechUtterance(string: thingToSay)
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
        
        animateActionButtonAppearance(true)

    }
    
    var currentStep = 0
    
    @IBAction func nextStepButton(sender: AnyObject) {
        
            
            if !speechSynthesizer.speaking {
                
                
                let step = recipe.directions[currentStep]
                
                
                speechUtterance = AVSpeechUtterance(string: step)
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitch
                speechUtterance.volume = volume
                
                speechSynthesizer.speakUtterance(speechUtterance)
                
                currentStep++
                
                if currentStep == recipe.directions.count { currentStep = 0 }
                
            } else {
                speechSynthesizer.continueSpeaking()
            }
        
        animateActionButtonAppearance(true)
        if !speechSynthesizer.speaking {
            animateActionButtonAppearance(false)
        }
        
    }
    
    @IBAction func pauseButton(sender: AnyObject) {
        
        speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
        
        animateActionButtonAppearance(false)
        
    }
    
    var speechUtterance: AVSpeechUtterance!
    
    @IBAction func lastButton(sender: AnyObject) {
        
        guard !speechSynthesizer.speaking else { return }
        
        if let utterance = speechUtterance {
            
            speechSynthesizer.speakUtterance(utterance)
            
        }
        
        animateActionButtonAppearance(false)
        
    }
    
    
    @IBAction func stopButton(sender: AnyObject) {
        
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Word)
        
        animateActionButtonAppearance(false)
        
    }
    
    func animateActionButtonAppearance(shouldHideSpeakButton: Bool) {

        var nextIngredientStepButtonsAlphaValue: CGFloat = 1.0
        var pauseLastStopButtonsAlphaValue: CGFloat = 0.0
        
        if shouldHideSpeakButton {
            
            nextIngredientStepButtonsAlphaValue = 0.0
            pauseLastStopButtonsAlphaValue = 1.0
            
        }
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.nextStack.alpha = nextIngredientStepButtonsAlphaValue
            
            self.buttonStack.alpha = pauseLastStopButtonsAlphaValue

            
        })
        
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        
    }
    
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        
    }
    
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
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
  

        var reuseID = ""

        
        if indexPath.section == 0 {
            
            reuseID = "IngredientCell"
            
        } else {
            
            reuseID = "StepCell"
            
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath)

        if indexPath.section == 0 {
            
            let ingredient = recipe.ingredients[indexPath.row]
            
      
            
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












