//
//  WorldScoresViewController.swift
//  MannDrops2
//
//  Created by hackeru on 11/30/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class WorldScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingLabel: UILabel!
    private var dataSet : [[String:Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimationsManager.shared.changeLabelTextAsync(label: loadingLabel, index: 0)
        FirebaseDBManager.shared.readAllScores(){(arr : [[String:Any]]) in //load scores
            self.dataSet = arr
            self.tableView.reloadData()
            self.loadingLabel.alpha = 0
            self.tableView.alpha = 1
            self.tableView.backgroundView = UIImageView(image: UIImage(named: "ocean_bg"))
            self.tableView.separatorStyle = .none
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSet.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ScoreCellTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScoreCellTableViewCell
        cell.configFromDict(self.dataSet[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.backgroundView?.backgroundColor = UIColor.clear
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

