//
//  DailyGoalsTests.swift
//  DailyGoalsTests
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import XCTest
import CoreData
@testable import DailyGoals

class DailyGoalsTests: XCTestCase {

    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        
        coreDataManager = CoreDataManager.shared
        

    }
    
    func testInitCoreDataManager() {
        let instance = CoreDataManager.shared
        
        XCTAssertNotNil (instance)
    }
    
    func test_create_data() {
        
        let goal = "New Daily Goal"
        let task1 = "Task 2"
        let task2 = "Task 2"
        let task3 = "Task 3"
        let date = NSDate()
        
        let dailyGoal1 = coreDataManager.saveGoalData(goal: goal, task1: task1, task2: task2, task3: task3, date: date)

        XCTAssertNotNil( dailyGoal1 )
        
    }
    


}

