//
//  ExercisesModel.swift
//  MannDrops
//
//  Created by hackeru on 10/27/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class ExercisesDataModel: NSObject {
    
    let types : [ExerciseType]
    let factories : [ExerciseFactory]
    
    init(types : [ExerciseType]){
        self.types = types
        self.factories = [ExerciseFactory()]
    }
    
    init(types : [ExerciseType], factories: [ExerciseFactory]){
        self.types = types
        self.factories = factories
    }
    
    class Easy : ExercisesDataModel{
        let easyExerciseTypes : [ExerciseType] = [ExerciseType(operatorType: "+", maxNumber: 10), ExerciseType(operatorType: "-", maxNumber: 10)]
        
        init(){
            super.init(types: easyExerciseTypes)
        }
    }
    
    
    class Normal : ExercisesDataModel{
        let normalExerciseTypes : [ExerciseType] = [ExerciseType(operatorType: "*", maxNumber: 10)]
        
        let normalFactories : [ExerciseFactory] = [ExerciseFactory(), ExerciseFactory(), ExerciseFactory(), DivideFactory(maxNumber : 10)] //        4 Exercisefactory for balancing each exercise type chances to be randomly tossed.
        
        init(){
            super.init(types: normalExerciseTypes, factories: normalFactories)
        }
    }
    
    class Hard : ExercisesDataModel{
        let hardExerciseTypes : [ExerciseType] = [ExerciseType(operatorType: "+", maxNumber: 50), ExerciseType(operatorType: "-", maxNumber: 50), ExerciseType(operatorType: "*", maxNumber: 15)]
        
        let hardFactories : [ExerciseFactory] = [ExerciseFactory(), ExerciseFactory(), ExerciseFactory(), DivideFactory(maxNumber : 15)]  //         4 Exercisefactory for balancing each exercise type chances to be randomly tossed.
        
        init(){
            super.init(types: hardExerciseTypes, factories: hardFactories)
        }
    }
}
