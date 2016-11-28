//
//  ExerciseDifficulty.swift
//  MannDrops
//
//  Created by hackeru on 10/10/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

let typesTag = "OperatorTypes"
let maxNumberTag = "MaxNumber"
var info : [String : Any] = [:]

enum ExerciseDifficulty{
    case EASY//([ExerciseFactory],Int)
    case NORMAL//([ExerciseFactory],Int)
    case HARD//([ExerciseFactory],Int)
    case CRAZY//([ExerciseFactory],Int)
    
    func generateDifficulatyInfo(){
       
        switch self {
            
        case .EASY:
            info[typesTag] = [OperatorType.Plus, OperatorType.Minus]
            info[maxNumberTag] = 10
            
        case .NORMAL:
            info[typesTag] = [OperatorType.Plus, OperatorType.Minus, OperatorType.Multiply, OperatorType.Divide]
            info[maxNumberTag] = 10
            
        case .HARD:
            info[typesTag] = [OperatorType.Plus, OperatorType.Minus, OperatorType.Multiply, OperatorType.Divide]
            info[maxNumberTag] = 15
            
        default: break
            
        }
    }
    
    func generateRandomOperator(info : [String : Any]) -> OperatorType{
        let types : [Any] = info[typesTag] as! [Any]
        let randomIndex = Int(arc4random_uniform(UInt32(types.count)))
        return types[randomIndex] as! OperatorType
    }
    
    func generateExcercise(model : ExercisesDataModel) -> String{
        generateDifficulatyInfo()
        let factory =  ExerciseFactory()
        return factory.generateExercise(maxNumber: info[maxNumberTag] as! Int)
    }
    /*
     func generateExercise(factories : [ExerciseFactory], maxNumber : Int) -> String{
     let randFactoryNumber = Int(arc4random_uniform(UInt32(factories.count - 1)))
     let factory = factories[randFactoryNumber]
     return factory.generateExercise(maxNumber: maxNumber)
     }*/
}
