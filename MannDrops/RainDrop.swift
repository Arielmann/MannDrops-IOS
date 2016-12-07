//
// Created by hackeru on 29 Sep 2016.
// Copyright (c) 2016 hackeru. All rights reserved.
//

import Foundation

class RainDrop {
    var exercise : String! = ""
    var answer : String! = ""
    var droppingTime : Double = 10 //Default dropping time is 10 secods
    
    init(exercise : String){
        let answer = AnswersManager.shared.generateAnswer(exercise: exercise)
        let droppingTime = Int(arc4random_uniform(UInt32(13 - 7))) + 7
        self.exercise = exercise
        self.answer = answer
        self.droppingTime = Double(droppingTime)
    }
}
