////
////  DailyGoalsTests.swift
////  DailyGoalsTests
////
////  Created by Carl Wainwright on 14/01/2019.
////  Copyright © 2019 Carl Wainwright. All rights reserved.
////
//
//import XCTest
//@testable import DailyGoals
//
//class DailyGoalsTests: XCTestCase {
//
//    var dailyTaskVC: DailyTaskViewController!
//    var customTable: CustomTable!
//    
//    override func setUp() {
//        super.setUp()
//        dailyTaskVC = DailyTaskViewController()
//        customTable = CustomTable()
//    }
//    
//    func testIfDataPullsThroughToASrraysFromAlertBox() {
//        
//        let goalText = "Goal"
//        let task1Test = "Task1"
//        let task2Test = "Task 2"
//        let task3Test = "Task 3"
//        
//        
//        dailyTaskVC.showGoalTaskDialog(goalPlaceHolder: goalText,
//                                       task1PlaceHolder: task1Test,
//                                       task2PlaceHolder: task2Test,
//                                       task3PlaceHolder: task3Test,
//                                       actionHandler: { (goalInput:String?, task1Input:String?, task2Input:String?, task3Input:String?) in
//                                        self.customTable.sectionData = [DailyGoalData(text: "\(Date().string(format: "dd MMM yyyy")) \n \(goalInput ?? "")")]
//                                        self.customTable.cellsData = [CellData(text: "\(task1Input ?? "")" ),
//                                                                      CellData(text: "\(task2Input ?? "")" ),
//                                                                      CellData(text: "\(task3Input ?? "")" )]
//                                        
//                                        
//        })
//        XCTAssertEqual(customTable.cellsData.count, 3)
//        XCTAssertEqual(customTable.sectionData[0].text, goalText)
//        XCTAssertEqual(customTable.cellsData[0].text, task1Test)
//        XCTAssertEqual(customTable.cellsData[1].text, task2Test)
//        XCTAssertEqual(customTable.cellsData[2].text, task3Test)
//        
//    }
//}
