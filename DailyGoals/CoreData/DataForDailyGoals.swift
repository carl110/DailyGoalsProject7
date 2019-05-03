//
//  DataForDailyGoals.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 29/04/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit
import CoreData

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
