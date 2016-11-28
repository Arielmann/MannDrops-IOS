//
//  DBManager.swift
//  MannDrops
//
//  Created by hackeru on 10/10/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit
import FirebaseDatabase

//*******************************NOTE: THIS CLASS IS NOT YET ACTIVE***********************//

// a complition block that gets an array of dictioneries, does something with it and returns void
typealias CompletionBlock = (_ arr : [[String:Any]]) -> Void

class DBManager: NSObject {
    static let shared = DBManager()
    
    var rootRef: FIRDatabaseReference
    
    override init() {
        
        rootRef = FIRDatabase.database().reference() //this is our unique data base path
        
        super.init()
    }
    
    func saveHighScore(score : [String:Any], targetUser : String){ //save highscore (the dictionary parameter) in firebase. it will save it under the user id (i.e uid) branch which is located in the HIGH SCORES branch
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
            
            completion(Array(dict.values))
        }
        //snapshot - a piece of information from out databse
        //observe = listener
        //value - an enum instance that means we are going to read the data (get the value)
        //go to the highscores branch, read what is written there using our observeFunc method
        rootRef.child(Config.TABLE_HIGHSCORES).observe(.value, with: observeFunc)
        
    }
}
