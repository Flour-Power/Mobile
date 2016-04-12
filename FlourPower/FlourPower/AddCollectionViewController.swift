//
//  AddCollectionViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 4/12/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "addCell"

class AddCollectionViewController: UICollectionViewController {
    
    var recipes: [Recipe] = []

    
    @IBOutlet weak var sButton: UIBarButtonItem!
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBOutlet var addCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

 

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        
        return cell
    }

  

}
