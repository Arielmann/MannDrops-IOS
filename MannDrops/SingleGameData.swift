//
//  SingleGameUserData.swift
//  MannDrops
//
//  Created by hackeru on 11/24/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class SingleGameData: NSObject {
    static var NAME = "You"
    static var SCORE = 0
    static var EXERCISES_SOLVED = 0
    static var ERRORS = 0
    static var LIVES = 3
    
    static func nullifyGameData(){
            SCORE = 0
            EXERCISES_SOLVED = 0
            ERRORS = 0
            LIVES = 3
    }
}
