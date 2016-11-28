//
//  SingleGameUserData.swift
//  MannDrops
//
//  Created by hackeru on 11/24/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class SingleGameData: NSObject {
    static var score = 0
    static var name = ""
    static var exercisesSolved = 0
    static var errors = 0
    static var lives = 3
    
    static func nullifyGameData(){
            score = 0
            exercisesSolved = 0
            errors = 0
            lives = 3
    }
}
