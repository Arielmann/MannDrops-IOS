//
//  SnippetStore.swift
//  SimpleScanner
//
//  Created by Ronen Lahat on 10/10/2016.
//  Copyright © 2016 Ronen Lahat. All rights reserved.
//

import UIKit
import CoreData

class SnippetStore: NSObject {
    
    static let shared = SnippetStore()
    
    let managedContext = DBManager.shared.context
    
    private override init() {
        print("SnippetStore Created")
    }
    
    var allSnippets : [Snippet] {
        get {
            let request: NSFetchRequest<Snippet> = NSFetchRequest<Snippet>()
            request.entity = NSEntityDescription.entity(forEntityName: "Snippet", in: managedContext)
            
            guard let arr = try? managedContext.fetch(request) else {
                return []
            }
            
            return arr
        }
    }
    
    func saveSnippet(title: String, text: String) {
        
        let entity =  NSEntityDescription.entity(forEntityName: "Snippet",
                                                 in:managedContext)
        
        let snippet = NSManagedObject(entity: entity!,
                                      insertInto: managedContext)
        
        snippet.setValue(title, forKey: "title")
        snippet.setValue(text, forKey: "text")
        snippet.setValue(Date(), forKey: "date")
        snippet.setValue(UUID().uuidString, forKey: "uuid")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func removeSnippet(_ snippet: Snippet) {
        managedContext.delete(snippet)
    }
    
}
