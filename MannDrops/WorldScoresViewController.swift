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
    private var dataSet : [[String:Any]] = [[:]]
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseDBManager.shared.readAllScores(){(arr : [[String:Any]]) in
            self.dataSet = arr
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "ocean_bg"))
        tableView.separatorStyle = .none
       
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ScoreCellTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScoreCellTableViewCell
        cell.configFromDict(dataSet[indexPath.row])
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
