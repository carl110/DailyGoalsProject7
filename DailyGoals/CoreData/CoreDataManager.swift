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
        managedObject.setValue(false, forKey: "task1Complete")
        managedObject.setValue(false, forKey: "task2Complete")
        managedObject.setValue(false, forKey: "task3Complete")
        
        do {
            try managedContext.save()
        } catch {
            let error = error as NSError
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteEntireTable() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "DailyGoal", in: context)
        fetchRequest.includesPropertyValues = false
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                context.delete(result)
            }
            try context.save()
            
        } catch {
            
            print("fetch error -\(error.localizedDescription)")
        }
    }
    

    func fetchGoalData() -> [DataForDailyGoals]?{
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DailyGoal")
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            var taskObjects: [DataForDailyGoals] = []
            
            tasks.forEach { (taskObject) in
                taskObjects.append(DataForDailyGoals(object: taskObject))
            }
            
            return taskObjects
        } catch let error as NSError {
            print ("Could not fetch. \(error) \(error.userInfo)")
            return nil
        }
    }
    
    func fetchIndividualData(savedObject: String) -> [String]? {
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequet = NSFetchRequest<DailyGoal>(entityName: "DailyGoal")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequet)
            
            var newArray = [String]()
            for item in fetchedResults {
                print (item.value(forKey: savedObject)!)
                newArray.append(item.value(forKey: savedObject) as! String)
                
            }
    return newArray
        } catch let error as NSError {
            print (error.description)
        }
        return nil
    }
  
    func fetchGoalDataForToday(date: String) -> [DataForDailyGoals]?{
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "date = %@", date)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DailyGoal")
        fetchRequest.predicate = predicate
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            var taskObjects: [DataForDailyGoals] = []
            
            tasks.forEach { (taskObject) in
                taskObjects.append(DataForDailyGoals(object: taskObject))
            }
            
            return taskObjects
        } catch let error as NSError {
            print ("Could not fetch. \(error) \(error.userInfo)")
            return nil
        }
    }
    
    func update(object: String,updatedEntry: Any, date: String) {
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "date = %@", date)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DailyGoal")
        fetchRequest.predicate = predicate
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            if let last = tasks.last {
                
                last.setValue(updatedEntry, forKey: object)
                
                do {
                    try managedContext.save()
                    
                } catch {
                    let error = error as NSError
                    fatalError("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
        catch let error as NSError {
            print ("Could not fetch. \(error). \(error.userInfo)")
        }
    }
}

class DataForDailyGoals {
    
    var goal: String
    var task1: String
    var task2: String
    var task3: String
    var date: String
    var task1Complete: Bool
    var task2Complete: Bool
    var task3Complete: Bool
    
    init(object: NSManagedObject) {
        
        self.goal = object.value(forKey: "goal") as! String
        self.task1 = object.value(forKey: "task1") as! String
        self.task2 = object.value(forKey: "task2") as! String
        self.task3 = object.value(forKey: "task3") as! String
        self.date = object.value(forKey: "date") as! String
        self.task1Complete = object.value(forKey: "task1Complete") as! Bool
        self.task2Complete = object.value(forKey: "task2Complete") as! Bool
        self.task3Complete = object.value(forKey: "task3Complete") as! Bool
    }
}
