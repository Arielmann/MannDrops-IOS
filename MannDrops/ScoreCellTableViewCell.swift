//
//  ScoreCellTableViewCell.swift
//  MannDrops
//
//  Created by hackeru on 11/21/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class ScoreCellTableViewCell: UITableViewCell {
    
    static let identifier = "score_cell"
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var exercisesSolved: UILabel!
    @IBOutlet weak var errorsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    public func config(_ score : Scores){
        playerNameLabel.text = score.name
        scoreLabel.text = String(score.score)
        exercisesSolved.text = String(score.exercises_solved)
        errorsLabel.text = String(score.errors)
        if let date = score.date{
            let formattedDate = Scores.formatDate(date: date)
            dateLabel.text = formattedDate
        }
    }
    
    public func configFromDict(_ score : [String:Any]){
        playerNameLabel.text = score[Config.NAME] as! String?
        guard //Removing optional wrapping the strings from data
            let scoreData = score[Config.SCORE],
            let exercisesSolvedData =  score[Config.EXERCISES_SOLVED],
            let errorsData = score[Config.ERRORS]
            else{
                return
        }
        scoreLabel.text = String(describing: scoreData)
        exercisesSolved.text = String(describing: exercisesSolvedData)
        errorsLabel.text = String(describing: errorsData)
        dateLabel.text = score[Config.DATE] as! String?
    }
}
