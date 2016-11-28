//
//  AnswersManager.swift
//  MannDrops
//
//  Created by hackeru on 11/2/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class AnswersManager: NSObject {
    
    static let shared = AnswersManager()
    var answers : [String] = []
    
    private override init(){} // prevent creating instances of this class
    
    public func generateAnswer(exercise : String) -> String{
        let mathExpression = NSExpression(format: exercise)
        if let result = mathExpression.expressionValue(with: nil, context: nil) as? Int{
            return String(describing: result)
        }
        print("Error generating answer")
        return "Error generating answer"
    }
    
    
    func handleUserAnswer(resultLabel : UILabel, rainDropVcDict : [String : RainDropViewController], goldenRainDropVcDict : [String : RainDropViewController]) {
        let userAnswerWithSpace = resultLabel.text!
        let finalUserAnswer = userAnswerWithSpace.trimmingCharacters(in: .whitespaces)
        let totalAnswerCount = rainDropVcDict.count + goldenRainDropVcDict.count
        
        for (key, goldenRainDropVC) in goldenRainDropVcDict {
            let answer = goldenRainDropVC.rainDrop.answer
            if(finalUserAnswer == answer!){
                print(" User has answered \(finalUserAnswer.description) and was correct. Answer:\(answer)")
                return //all rainDrops are removed. Exit method
            }
        }
        
        for (key, rainDropVC) in rainDropVcDict {
            let answer = rainDropVC.rainDrop.answer
            if(finalUserAnswer == answer!){
                print(" User has answered \(finalUserAnswer.description) and was correct. Answer:\(answer)")
                }
            else{
                print("Current index answer: \(answer) doesn't match user's answer \(finalUserAnswer.description)")
            }
        }

    }
}


