//
//  TimersDataModel.swift
//  MannDrops
//
//  Created by hackeru on 11/9/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class TimersManager: NSObject {
    
    static let shared = TimersManager()
    public var timers = [Timer]()
    
    /*
     Class was created for managing timing of exercises creating
     
     The game has two type of timers:
     
     1. Exercise adding timers
     2. NON REPEATING timers for initializing exercise adding timers
     
     In addition, an inner class was created for defining every exercises timer data (ExercisesTimerModel)
     */
    
    class ExercisesTimerModel: NSObject {
        
        let initAfter: Int
        let fireExerciseEvery: Double
        let exerciseModel : ExercisesDataModel
        let repeating : Bool
        
        
        init(initTime : Int, fireExerciseEvery: Double, exerciseModel: ExercisesDataModel, repeating : Bool) {
            self.initAfter = initTime
            self.fireExerciseEvery = fireExerciseEvery
            self.exerciseModel = exerciseModel
            self.repeating = repeating
            
        }
    }
    
    public func initTimers(controller : GameViewController){
        
        timers.append(Timer.scheduledTimer(timeInterval: 0, target: controller, selector: #selector(GameViewController.willAnimateRainDrop(timer:)), userInfo: ExercisesDataModel.Easy(), repeats: false)) //init first exercise after zero seconds. non repeatable
         timers.append(Timer.scheduledTimer(timeInterval: 2, target: controller, selector: #selector(GameViewController.willAnimateRainDrop(timer:)), userInfo: ExercisesDataModel.Easy(), repeats: true))
         timers.append(Timer.scheduledTimer(timeInterval: 2, target: controller, selector: #selector(GameViewController.willAnimateRainDrop(timer:)), userInfo: ExercisesDataModel.Easy(), repeats: true))
        
        var exerciseTimerModels = [ExercisesTimerModel]() //Define exercise timers
        
        exerciseTimerModels.append(ExercisesTimerModel(initTime: 7, fireExerciseEvery: 7, exerciseModel: ExercisesDataModel.Easy(), repeating: true))
        exerciseTimerModels.append(ExercisesTimerModel(initTime: 20,  fireExerciseEvery: 7, exerciseModel: ExercisesDataModel.Normal(), repeating: true))
        exerciseTimerModels.append(ExercisesTimerModel(initTime: 30,  fireExerciseEvery: 10, exerciseModel: ExercisesDataModel.Normal(), repeating: true))
        exerciseTimerModels.append(ExercisesTimerModel(initTime: 50,  fireExerciseEvery: 10, exerciseModel: ExercisesDataModel.Hard(), repeating: true))
        exerciseTimerModels.append(ExercisesTimerModel(initTime: 60,  fireExerciseEvery: 4, exerciseModel: ExercisesDataModel.Easy(), repeating: true))
        exerciseTimerModels.append(ExercisesTimerModel(initTime: 65,  fireExerciseEvery: 7, exerciseModel: ExercisesDataModel.Normal(), repeating: true))
        
        
        var goldenExerciseTimers = [ExercisesTimerModel]() //Define Golden exercise timers
        goldenExerciseTimers.append(ExercisesTimerModel(initTime: 0, fireExerciseEvery: 35, exerciseModel: ExercisesDataModel.Normal(), repeating: true))
        goldenExerciseTimers.append(ExercisesTimerModel(initTime: 0,  fireExerciseEvery: 73, exerciseModel: ExercisesDataModel.Normal(), repeating: true))
        
        //We use the Timer.userInfo property to send the scheduling information to the
        // addExerciseTimer moethod which starts the actual timer
        for (_, exerciseTimerModel) in exerciseTimerModels.enumerated(){
            var timerInfo = [String : Any]()
            timerInfo["controller"] = controller
            timerInfo["model"] = exerciseTimerModel
            timers.append(Timer.scheduledTimer(timeInterval: TimeInterval(exerciseTimerModel.initAfter), target: self, selector: #selector(addExercisesTimer), userInfo: timerInfo, repeats: false))
        }
        
        for (_, exerciseTimerModel) in goldenExerciseTimers.enumerated(){ //immidietly add golden timers
            var timerInfo = [String : Any]()
            timerInfo["controller"] = controller
            timerInfo["model"] = exerciseTimerModel
            timers.append(Timer.scheduledTimer(timeInterval: TimeInterval(exerciseTimerModel.initAfter), target: self, selector: #selector(addGoldenExercisesTimer), userInfo: timerInfo, repeats: false))
        }
    }
    
    public func addExercisesTimer(timer: Timer){
        let timerInfo = timer.userInfo as! [String : Any]
        let controller : GameViewController = timerInfo["controller"] as! GameViewController
        let model : ExercisesTimerModel = timerInfo["model"] as! ExercisesTimerModel
        initSingleExercisesTimer(gameController : controller, model: model)
    }
    
    public func addGoldenExercisesTimer(timer: Timer){
        let timerInfo = timer.userInfo as! [String : Any]
        let controller : GameViewController = timerInfo["controller"] as! GameViewController
        let model : ExercisesTimerModel = timerInfo["model"] as! ExercisesTimerModel
        timers.append(Timer.scheduledTimer(timeInterval: model.fireExerciseEvery, target: controller, selector: #selector(GameViewController.willAnimateGoldenRainDrop), userInfo: model.exerciseModel, repeats: model.repeating))
    }
    
    public func InvalidateAllTimers(){
        for timer in timers{
            timer.invalidate()
        }
        timers.removeAll()
    }
    
    public func initSingleExercisesTimer(gameController : GameViewController, model : ExercisesTimerModel){ //Method is also being called in game view controller
        timers.append(Timer.scheduledTimer(timeInterval: model.fireExerciseEvery, target: gameController, selector: #selector(GameViewController.willAnimateRainDrop), userInfo: model.exerciseModel, repeats: model.repeating))
    }
}
