//
//  ExerciseType.swift
//  MannDrops
//
//  Created by hackeru on 11/2/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class ExerciseType: NSObject {

    let operatorType : String
    let maxNumber : Int
    
    init(operatorType : String, maxNumber : Int){
        self.operatorType = operatorType
        self.maxNumber = maxNumber
    }
}
