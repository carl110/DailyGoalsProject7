//
//  DailyGoalsTests.swift
//  DailyGoalsTests
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import XCTest
@testable import DailyGoals

class DailyGoalsTests: XCTestCase {

    var dailyTaskVC: DailyTaskViewController!
    
    override func setUp() {
        super.setUp()
        dailyTaskVC = DailyTaskViewController()
    }
    
    func testIfDataPullsThroughToASrraysFromAlertBox() {
        dailyTaskVC.showGoalTaskDialog(title: "Title",
                                       subtitle: "Subtitle",
                                       actionTitle: "ActionTitle",
                                       goalPlaceHolder: "Goal",
                                       task1PlaceHolder: "Task 1",
                                       task2PlaceHolder: "Task 2",
                                       task3PlaceHolder: "Task 3",
                                       actionHandler: { (goalInput:String?, task1Input:String?, task2Input:String?, task3Input:String?) in
                                        
                                        if (goalInput?.isEmpty)! || (task1Input?.isEmpty)! || (task2Input?.isEmpty)! || (task3Input?.isEmpty)! {
                                            
                                            self.dailyTaskVC.warningMessage()
                                            
                                        } else {
                                            self.dailyTaskVC.sectionData = [DailyGoalData(text: "\(Date().string(format: "dd MMM yyyy")) \n \(goalInput ?? "")")]
                                            self.dailyTaskVC.cellsData = [CellData(text: "\(task1Input ?? "")" ),
                                                              CellData(text: "\(task2Input ?? "")" ),
                                                              CellData(text: "\(task3Input ?? "")" )]
                                            self.dailyTaskVC.dailyTaskTableView.reloadData()
                                        }
        })
        XCTAssertEqual(dailyTaskVC.cellsData.count, 3)
        XCTAssertEqual(dailyTaskVC.sectionData[0].text, "Title")
        
    }
}
