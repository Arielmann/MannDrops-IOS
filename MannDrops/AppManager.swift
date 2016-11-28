//
//  AppManager.swift
//  MannDrops
//
//  Created by hackeru on 10/13/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class AppManager: NSObject {
    
    //*********************NOTE: THIS CLASS IS NOT YET ACTIVE************************//
    
    static let shared = AppManager()
    
    var uid : String?{
        get{
            return UserDefaults.standard.object(forKey: "uid") as? String
        }
        set (newUID){
            let defaults = UserDefaults.standard
            defaults.set(newUID, forKey: "uid")
            defaults.synchronize()
        }
    }
    
    var userName : String?{
        get{
            return UserDefaults.standard.object(forKey: "user_name") as? String
        }
        set (newUID){
            let defaults = UserDefaults.standard
            defaults.set(newUID, forKey: "user_name")
            defaults.synchronize()
        }
    }
    
    func isLoggedIn() -> Bool{
        return uid != nil
    }
    
    
    
}
