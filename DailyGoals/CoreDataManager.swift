//
//  CoreDataManager.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 04/03/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    class var shared : CoreDataManager {
        struct Singleton {
            static let instance = CoreDataManager()
        }
        return Singleton.instance
    }
    
    func saveGoalData (goal: String, task1: String, task2: String, task3: String, date: NSDate) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "DailyGoal", in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        managedObject.setValue(goal, forKey: "goal")
        managedObject.setValue(task1, forKey: "task1")
        managedObject.setValue(task2, forKey: "task2")
        managedObject.setValue(task3, forKey: "task3")
        managedObject.setValue(date, forKey: "date")
        
        do {
            try managedContext.save()
        } catch {
            let error = error as NSError
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateGoalData (taskData: String, date: NSDate) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DailyGoal")
        let predicate = NSPredicate(format: "\(date)")
        fetchRequest.predicate = predicate
        do{
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1
            {
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(taskData, forKey: taskData)
                do{
                    try managedContext.save()
                }
                catch {
                    print (error)
                }
            }
        }
        catch {
            print (error)
        }

        
    }
    
    func fetchGoalData(date: NSDate) {
        
        
        
    }
    
    
}
