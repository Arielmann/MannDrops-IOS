//
//  DivideFactory.swift
//  MannDrops
//
//  Created by hackeru on 10/27/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class DivideFactory: ExerciseFactory {
    
    let maxNumber : Int
    
    init(maxNumber : Int){
        self.maxNumber = maxNumber
    }
    
    public override func generateExercise(type : ExerciseType) -> String{
        
        /*
         exerciseType is not used. Needed only
         for fully overriding the method in the parent class.
         
         To create a division exercise we multiply 2 random numbers and
         return the result divided by one of them (the first number in this case)
         */
        
        let firstNum = arc4random_uniform(UInt32(maxNumber)) + 1 //Prevent instances of the number 0
        let secondNum = arc4random_uniform(UInt32(firstNum)) + 1//Prevent instances of the number 0
        let multiplyResult = String(firstNum * secondNum)
        //let answer = operatorType.answer(n1: <#T##Int#>, n2: <#T##Int#>)
        
        return multiplyResult + " " + "/" + " " + String(firstNum)
    }
    
}
