//
//  ExerciseFactory.swift
//  MannDrops
//
//  Created by hackeru on 10/10/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class ExerciseFactory: NSObject {
    
    var answer : String = ""
    
    public override init(){
        super.init()
    }
    
    public func generateExercise(type: ExerciseType) -> String{
        let num1 = arc4random_uniform(UInt32(type.maxNumber))
        let num2 = arc4random_uniform(UInt32(type.maxNumber))
        
        if(num2 > num1){
            //second number is larger therefore will be treated as the first number in the exercise
            return String(num2) + " " + type.operatorType + " " + String(num1)
        }
        return String(num1) + type.operatorType + String(num2)
    }
}
