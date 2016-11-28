//
//  ScoreCellTableViewCell.swift
//  MannDrops
//
//  Created by hackeru on 11/21/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class ScoreCellTableViewCell: UITableViewCell {
    
    //**********************NOTE: THIS CLASS IS NOT YET ACTIVE*********************************//
    
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
        dateLabel.text = String(describing: score.date)
    }
}
