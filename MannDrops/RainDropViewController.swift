//
//  RainDropViewController.swift
//  MannDrops
//
//  Created by hackeru hackeru on 05/10/2016.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class RainDropViewController: UIViewController {
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var rainDrop: RainDrop! = RainDrop(exercise : "0 + 0") //Default initializing/ altered during init()
    
    init(rainDrop: RainDrop){
        super.init(nibName: nil, bundle: nil)
        self.rainDrop = rainDrop
        self.rainDrop.exercise = rainDrop.exercise
        print("Started RainDrop init")
        let nib = UINib(nibName: "RainDropViewController", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        self.exerciseLabel.text = rainDrop.exercise
        self.view.frame.size = CGSize(width: 75, height: 75)
        self.exerciseLabel.text = rainDrop.exercise
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
