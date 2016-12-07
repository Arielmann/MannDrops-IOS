//
//  DBManager.swift
//  MannDrops
//
//  Created by hackeru on 10/10/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit
import FirebaseDatabase

// a complition block that gets an array of dictioneries, does something with it and returns void
typealias CompletionBlock = (_ arr : [[String:Any]]) -> Void

class FirebaseDBManager: NSObject {
    static let shared = FirebaseDBManager()
    
    var rootRef: FIRDatabaseReference
    
    override init() {
        rootRef = FIRDatabase.database().reference() //this is our unique data base path
        super.init()
    }
    
    func saveHighScore(score : [String:Any], targetUser : String){ //save highscore (the dictionary parameter) in firebase. it will save it under the user id (i.e targetUser parameter which holds a uid) branch which is located in the HIGH SCORES branch
        rootRef.child(Config.TABLE_HIGHSCORES).child(targetUser).setValue(score)
    }
    
    func saveGroup(score : [String:Any], groupName : String, targetUser : String){
        rootRef.child(Config.TABLE_GROUPS).child(groupName).child(targetUser).setValue(score)
    }
    
    func signUp(user : [String:String]) -> String{
        let uid = rootRef.child(Config.TABLE_USERS).childByAutoId().key // let firebase generate our new user an unique id
        rootRef.child(Config.TABLE_USERS).child(uid).setValue(user) //firebase knows how to recieve a DICTIONARY (i.e user) and creats it as the value for the user
        
        return uid
    }
    
    func readAllScores(completion : @escaping CompletionBlock){
        func observeFunc(snapshot : FIRDataSnapshot){
            guard let dict = snapshot.value as? [String:[String:Any]] else {
                completion([])
                return
            }
            let unsortedDictsArray = Array(dict.values)
            let sortedDictsArray = sortScoreDictsArray(unSortedDictsArray: unsortedDictsArray)
            completion(sortedDictsArray)
        }
        rootRef.child(Config.TABLE_HIGHSCORES).observe(.value, with: observeFunc) //go to the highscores branch, read what is written there using our observeFunc method
        // For limiting query: rootRef.child(Config.TABLE_HIGHSCORES).queryLimited(toLast: 10).observe(.value, with: observeFunc)
        
        /*
          Terms key:
          snapshot - A piece of information from out databse
          observe = Listener
          value - An enum instance that means we are going to read the data (get the value)
       */
 
    }
    
    
    private func sortScoreDictsArray(unSortedDictsArray: [[String:Any]]) -> [[String:Any]]{
        let sortedDictsArray = unSortedDictsArray.sorted {
            scoreDataObj1, scoreDataObj2 in //define 2 score dictioneries from the array of dictioneries
            let score1 = scoreDataObj1[Config.SCORE] as! Int //unwrap their score value
            let score2 = scoreDataObj2[Config.SCORE] as! Int
            return score1 > score2 //comapre
        }
        return sortedDictsArray
    }
}
