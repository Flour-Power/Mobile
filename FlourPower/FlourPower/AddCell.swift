//
//  AddCell.swift
//  FlourPower
//
//  Created by Kelly Robinson on 4/12/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

class AddCell: UICollectionViewCell {
    
    var recipeInfo: Recipe!

    
    @IBOutlet weak var addImageView: UIImageView!
    
    
    @IBOutlet weak var recipeNameText: UITextField!
    
    @IBOutlet weak var ingredientsText: UITextView!
    
    @IBOutlet weak var directionsText: UITextView!
    
    
}
