//
//  RandomFactory.swift
//  MannDrops
//
//  Created by hackeru on 11/14/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class RandomFactory: NSObject {

    static func generateNumberBetweenTwoValues(maxValue : Int, minValue : Int) -> Int{
        return Int(arc4random_uniform(UInt32(maxValue - minValue))) + minValue
    }
    
    static func generateNumber(num : Int) -> Int{
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    
}
