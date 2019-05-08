//
//  DateTest.swift
//  DailyGoalsTests
//
//  Created by Carl Wainwright on 28/02/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.


import XCTest
@testable import DailyGoals

class CheckBoxTest: XCTestCase {
    
    var checkBox = CheckBox()
    var tableViewCell = TableViewCell()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCheckBoxIsSameAsCustomCellState() {

        XCTAssertEqual(tableViewCell.isToggled == true, checkBox.isChecked == true, "Checkbox should be true when table cell toggle is true")
    }
}
