//
//  ScoresTableViewController.swift
//  MannDrops
//
//  Created by hackeru on 11/21/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class LocalScoresTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "ocean_bg"))
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Scores.allScores.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ScoreCellTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScoreCellTableViewCell
        cell.config(Scores.allScores[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.backgroundView?.backgroundColor = UIColor.clear
        return cell
    }
}
