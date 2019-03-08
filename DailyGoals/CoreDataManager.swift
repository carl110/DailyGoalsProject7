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
        
        let dailyGoal = NSEntityDescription.entity(forEntityName: "DailyGoal", in: managedContext)!
        let goalData = NSManagedObject(entity: dailyGoal, insertInto: managedContext)
        
        goalData.setValue(goal, forKey: "goal")
        goalData.setValue(task1, forKey: "task1")
        goalData.setValue(task2, forKey: "task2")
        goalData.setValue(task3, forKey: "task3")
        goalData.setValue(date, forKey: "date")
        
        do {
            try managedContext.save()
      
        } catch {
            let error = error as NSError
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
        
        
    }
    
}
