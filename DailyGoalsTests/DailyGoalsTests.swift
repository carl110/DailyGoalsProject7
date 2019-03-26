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
//Tests run in alphabetical order, changed names to testa etc. to create and order
class CoreDataTests: XCTestCase {

    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager.shared
    }

    func initCoreDataManager() {
        let instance = CoreDataManager.shared
        XCTAssertNotNil (instance)
    }
    
    func saveGoalData() {
        let goal = "New Daily Goal"
        let task1 = "Task 2"
        let task2 = "Task 2"
        let task3 = "Task 3"
        let date = "Date"
        
        let dailyGoal1 = coreDataManager.saveGoalData(goal: goal, task1: task1, task2: task2, task3: task3, date: date)
        let dailyGoal2 = coreDataManager.saveGoalData(goal: goal, task1: task1, task2: task2, task3: task3, date: date)

        XCTAssertNotNil( dailyGoal1 )
        XCTAssertNotNil( dailyGoal2 )
    }
    
    func fetchGoals() {
        let results = coreDataManager.fetchGoalData()
        
        dump(results)
        
        XCTAssertEqual(results?.count, 2)
    }
    
    func deleteEntireTable() {
        coreDataManager.deleteEntireTable()
        XCTAssertEqual(coreDataManager.fetchGoalData()?.count, 0)
    }
    //since tests are run alphabetically, using the below
    func testRunInOrder() {
        initCoreDataManager()
        saveGoalData()
        fetchGoals()
        deleteEntireTable()
    }
}

