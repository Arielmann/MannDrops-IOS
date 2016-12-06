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

class Scores: NSManagedObject {
    
    @NSManaged var item_id : String?
    @NSManaged var name : String?
    @NSManaged var score : Int16
    @NSManaged var exercises_solved : Int16
    @NSManaged var errors : Int16
    @NSManaged var date : Date?
    
    
    func dictionaryRepresentation() -> [String:Any]?{
        
        guard let uid = AppManager.shared.uid else {
            print("no user id found")
            return nil
        }
        
        return [ //create the score dictionary with the values
            Config.NAME: name ?? "Anonymous",
            Config.SCORE: Int(score),
            Config.EXERCISES_SOLVED: Int(exercises_solved),
            Config.ERRORS: Int(errors),
            Config.DATE: Scores.formatDate(date: date!),
            Config.UID: uid
        ]
    }
    
    static var allScores : [Scores] {
        get {
            let managedContext = LocalDBManager.shared.context
            let request: NSFetchRequest<Scores> = NSFetchRequest<Scores>()
            request.entity = NSEntityDescription.entity(forEntityName: "Scores", in: managedContext)
            
            guard let unSortedarr = try? managedContext.fetch(request) else {
                return []
            }
            
            let sortedArr = sortAllScores(unSortedArr: unSortedarr)
            
            return sortedArr
        }
    }
    
    static func saveScore(name: String, score : Int, exercisesSolved : Int, errors: Int) -> [String:Any]{
        print("Entered score saving method") //TODO: shorten function, break it to smaller functions
        let managedContext = LocalDBManager.shared.context
        let entity =  NSEntityDescription.entity(forEntityName: "Scores", in:managedContext)
        let newScoreData = NSManagedObject(entity: entity!, insertInto: managedContext)
        newScoreData.setValue(name, forKey: Config.NAME)
        newScoreData.setValue(score, forKey: Config.SCORE)
        newScoreData.setValue(exercisesSolved, forKey: Config.EXERCISES_SOLVED)
        newScoreData.setValue(errors, forKey: Config.ERRORS)
        newScoreData.setValue("N/A", forKey: Config.ELAPSED_TIME)
        let date : Date = Date()
        newScoreData.setValue(date, forKey: Config.DATE)
        newScoreData.setValue(UUID().uuidString, forKey: Config.ITEM_ID)
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        return [ //create the score dictionary with the values
            Config.NAME: name,
            Config.SCORE: Int(score),
            Config.EXERCISES_SOLVED: exercisesSolved,
            Config.ERRORS: Int(errors),
            Config.DATE: Scores.formatDate(date: date),
        ]
    }
    
    static func removeScore(_ score: Scores) {
        let managedContext = LocalDBManager.shared.context
        managedContext.delete(score)
    }
    
    static func removeAllScores() {
        for score in Scores.allScores{
            removeScore(score)
        }
    }
    
    static func deleteAllScores(){
        for score in allScores{
            removeScore(score)
            // try? managedContext.save() - MUST ADD FOR SAVING THE DELETE ACTION
        }
        let managedContext = LocalDBManager.shared.context
        try? managedContext.save()
    }
    
    func saveScoreInEndGame() {
        SwiftEventBus.onMainThread(self, name:"gameEnded") { _ in
            //SwiftEventBus.post("login", sender: Person(name: "cesar ferreira"))
            
        }
    }
    
    static func formatDate(date : Date) -> String{ //TODO: in core data the Date property should be a string from the first place!!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private static func sortAllScores(unSortedArr: [Scores]) -> [Scores]{
        let sortedArr = unSortedArr.sorted(by: {$0.score > $1.score})
        return sortedArr
    }
}


