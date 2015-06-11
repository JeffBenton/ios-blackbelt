//
//  Task.swift
//  beastlistblackbelt
//
//  Created by Jeff on 5/14/15.
//  Copyright (c) 2015 Jeff. All rights reserved.
//

import Foundation
class Task: NSObject, NSCoding {
    static var key: String = "Beast"
    static var schema: String = "theList"
    var objective: String?
    var createdAt: NSDate?
    var completedAt: NSDate?
    var done: Bool
    
    init(obj: String?) {
        self.objective = obj
        self.createdAt = NSDate()
        self.done = false
        self.completedAt = nil
    }
    
    // Mark - NSCoding protocol
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
        aCoder.encodeObject(completedAt, forKey: "completedAt")
        aCoder.encodeObject(done, forKey: "done")
    }
    required init(coder aDecoder: NSCoder) {
        objective = aDecoder.decodeObjectForKey("objective") as? String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as? NSDate
        completedAt = aDecoder.decodeObjectForKey("completedAt") as? NSDate
        done = aDecoder.decodeObjectForKey("done") as! Bool
    }
    
    // Mark - Queries
    static func all() -> [Task] {
        var tasks = [Task]()
        let path = Database.dataFilePath("theList")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                tasks = unarchiver.decodeObjectForKey(Task.key) as! [Task]
                unarchiver.finishDecoding()
            }
        }
        return tasks
    }
    static func getAllToBeast() -> [Task] {
        var notBeastedTasks = [Task]()
        var allTasks = Task.all()
        for i in allTasks {
            if i.done == false {
                notBeastedTasks.append(i)
            }
        }
        return notBeastedTasks
    }
    static func getAllBeasted() -> [Task] {
        var beastedTasks = [Task]()
        var allTasks = Task.all()
        for i in allTasks {
            if i.done == true {
                beastedTasks.append(i)
            }
        }
        return beastedTasks
    }
    func delete() {
        var tasksFromStorage = Task.all()
        for var i = 0; i < tasksFromStorage.count; ++i {
            if tasksFromStorage[i].createdAt == self.createdAt {
                tasksFromStorage.removeAtIndex(i)
            }
        }
        Database.save(tasksFromStorage, toSchema: Task.schema, forKey: Task.key)
    }
    func save() {
        var tasksFromStorage = Task.all()
        var exists = false
        for var i = 0; i < tasksFromStorage.count; ++i {
            if tasksFromStorage[i].createdAt == self.createdAt {
                tasksFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            tasksFromStorage.append(self)
        }
        Database.save(tasksFromStorage, toSchema: Task.schema, forKey: Task.key)
    }
}