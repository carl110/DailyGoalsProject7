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
    
    func saveGoalData (goal: String, task1: String, task2: String, task3: String, date: String) {
        
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
    
    func delete(object: NSManagedObject, completion: () -> Void)
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(object)
        
        do {
            try managedContext.save()
            completion()
            
        } catch let error as NSError
        {
            print(error)
        }
    }
    
    func updateGoal(object: NSManagedObject ,goal: String, task1: String, task2: String, task3: String, date: String) {
        
        delete(object: object) {
            saveGoalData(goal: goal, task1: task1, task2: task2, task3: task3, date: date)
        }
    }
    
    
    func fetchGoalData() -> [DailyGoal]?{
        
     
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DailyGoal")
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            return tasks as? [DailyGoal]
        } catch let error as NSError {
            print ("Could not fetch. \(error). \(error.userInfo)")
            return nil
        }
        
    }
    
    func fetchIndividualData(date: String, managedObject: String) -> [DailyGoal]? {
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: date)

        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let task = data.value(forKey: managedObject)
                return task as? [DailyGoal]}
                return result as? [DailyGoal]
            } catch let error as NSError {
            print ("Could not fetch. \(error). \(error.userInfo)")
            return nil
        }
        
    }
    
    //solution 1
    func update(goal: String, date: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: "DailyGoal", in: managedContext)
        
        let predicate = NSPredicate(format: date, argumentArray: nil)
        fetchRequest.predicate = predicate
//        fetchRequest.fetchLimit = 1
        fetchRequest.entity = entity
        
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1
            {
                
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(goal, forKey: "goal")
                
                do {
                    try managedContext.save()
                    
                } catch {
                    let error = error as NSError
                    fatalError("Could not save. \(error), \(error.userInfo)")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func updateGoalData (taskData: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "DailyGoal", in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)

        
        managedObject.setValue(taskData, forKey: "goal")

        
        do{
            try managedContext.save()
                print ("Saved!")
                }
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    } 
    
    
    
}
