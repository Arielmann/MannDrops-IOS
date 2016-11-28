//
//  RainDropFactory.swift
//  MannDrops
//
//  Created by hackeru on 11/14/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class RainDropFactory: NSObject {
    
    static func generateRainDrop(exerciseDataModel : ExercisesDataModel) -> RainDrop{
        let exercise = generateRainDropExercise(model: exerciseDataModel)
        let rainDrop = RainDrop(exercise : exercise)
        return rainDrop
    }

    private static func generateRainDropExercise(model : ExercisesDataModel) -> String{
        let factoriesArraySize = model.factories.count
        let factory : ExerciseFactory = model.factories[RandomFactory.generateNumber(num: factoriesArraySize)]
        let typesArraySize = model.types.count
        let type : ExerciseType = model.types[RandomFactory.generateNumber(num: typesArraySize)]
        return factory.generateExercise(type: type)
    }
}
