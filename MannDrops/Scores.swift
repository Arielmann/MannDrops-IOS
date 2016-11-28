//
//  Scores.swift
//  MannDrops
//
//  Created by hackeru on 10/10/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit
import CoreData
import SwiftEventBus

//**********************NOTE: THIS CLASS IS NOT YET ACTIVE*********************************//

class Scores: NSManagedObject {
    
    @NSManaged var item_id : String?
    @NSManaged var name : String?
    @NSManaged var score : Int16
    @NSManaged var exercises_solved : Int16
    @NSManaged var errors : Int16
    @NSManaged var date : Date?
    
    override static func initialize(){
        SwiftEventBus.onMainThread(self, name:"gameEnded") { _ in
            self.saveScore(name: SingleGameData.name, score: SingleGameData.score, exercisesSolved: SingleGameData.exercisesSolved, errors: SingleGameData.errors, elaspedTime: "Feature not yet avialable")
        }
    }
    
    
    func dictionaryRepresentation() -> [String:Any]?{
        guard let uid = AppManager.shared.uid /*, let user_name = AppManager.shared.userName */ else {
            print("no user id found")
            return nil
        }
        
        return [
            "date":date ?? Date(),
            "score":Int(score),
            "exercises":Int(exercises_solved),
            "uid":uid,
            "user_name":name ?? ""
            /*,"user_name":user_name*/
        ]
    }
    
    static var allScores : [Scores] {
        get {
            let managedContext = LocalDBManager.shared.context
            let request: NSFetchRequest<Scores> = NSFetchRequest<Scores>()
            request.entity = NSEntityDescription.entity(forEntityName: "Scores", in: managedContext)
            
            guard let arr = try? managedContext.fetch(request) else {
                return []
            }
            
            return arr
        }
    }
    
    static func saveScore(name: String, score : Int, exercisesSolved : Int, errors: Int, elaspedTime : String) {
        print("Entered score saving method")
        
        let managedContext = LocalDBManager.shared.context
        
        let entity =  NSEntityDescription.entity(forEntityName: "Scores",
                                                 in:managedContext)
        
        let newScoreData = NSManagedObject(entity: entity!,
                                           insertInto: managedContext)
        
        newScoreData.setValue(name, forKey: "name")
        newScoreData.setValue(score, forKey: "score")
        newScoreData.setValue(exercisesSolved, forKey: "exercises_solved")
        newScoreData.setValue(errors, forKey: "errors")
        newScoreData.setValue(elaspedTime, forKey: "elapsed_time")
        newScoreData.setValue(Date(), forKey: "date")
        newScoreData.setValue(UUID().uuidString, forKey: "item_id")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    static func removeScore(_ score: Scores) {
        let managedContext = LocalDBManager.shared.context
        
        managedContext.delete(score)
        try? managedContext.save() //save delete action
    }
}

