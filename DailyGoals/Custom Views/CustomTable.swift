//
//  CustomTable.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 25/02/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class CustomTable: UITableView, UITableViewDataSource, UITableViewDelegate,  CheckBoxDelegate, HeaderSectionDelegate  {
    
    fileprivate var dailyTaskViewModel = DailyTaskViewModel()
    
    var cellsData: [CellData] = [CellData(text: "Task 1"), CellData(text: "Task 2"), CellData(text: "Task 3")]
    var sectionData:[DailyGoalData] = [DailyGoalData(text: "Goal")]
    
    override func awakeFromNib() {
        delegate = self
        dataSource = self
        
        //setup custom cell
        self.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        self.estimatedRowHeight = 100
        self.rowHeight = UITableView.automaticDimension
        
        //call custom header
        let headerNib = UINib.init(nibName: "CustomHeader", bundle: Bundle.main)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: "CustomHeader")
        self.sectionHeaderHeight = UITableView.automaticDimension
        self.estimatedSectionHeaderHeight = 80
        
        //hide unused rows
        self.tableFooterView = UIView()
    }
    
    //Number of section required for table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //setup custom header as header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
        headerView.checkBox.checkBoxDelegate = self
        headerView.checkBox.owner = .Goal
        headerView.config(goal: sectionData[section])
        headerView.tag = section
        headerView.delegate = self
        return headerView
    }
    
    //setup custom cell as row cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.config(task: cellsData[indexPath.row], checkBoxState: dailyTaskViewModel.goalState)
        cell.checkBox.checkBoxDelegate = self
        cell.checkBox.owner = .Task
        return cell
    }
    
    //what to do when row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        //set previouse state
        self.visibleCells.forEach{ (cell) in
            (cell as! TableViewCell).isPreviouseState = (cell as! TableViewCell).checkBox.isChecked
        }
        cell.toggle()
        
        //check if any task cell is false
        if cell.isToggled == false {
            dailyTaskViewModel.goalState = nil
            let header = tableView.headerView(forSection: 0) as! CustomHeader
            header.checkBox.isChecked = false
            //            congratsMessage(title: "You'll get there", message: "Keep on going")
        }
        allCellsTrue(rows: self.visibleCells)
    }
    
    //check to see if all cells show true (isChecked)
    func allCellsTrue(rows: [UITableViewCell]) {
        var trueCount = 0
        rows.forEach { (cell) in
            if (cell as! TableViewCell).checkBox.isChecked == true {
                trueCount += 1
            }
        }
        let header = self.headerView(forSection: 0) as! CustomHeader
        //Messages for checking/unchecking goal
        if trueCount == rows.count {
            header.checkBox.isChecked = true
            //            congratsMessage(title: "Congratulations", message: "You have completed your Goal for today.")
        }
        if trueCount < rows.count {
            //            congratsMessage(title: "You're almost there", message: "Only \(rows.count - trueCount) more tasks to complete")
        }
    }
    
    func headerSectionCell(_ cell: CustomHeader) {
        //if goal is true then all tasks true
        let rowCell = self.visibleCells
        if cell.checkBox.isChecked == true {
            //set previouse state to checkboxState
            rowCell.forEach{ (row) in
                (row as! TableViewCell).isPreviouseState = (row as! TableViewCell).checkBox.isChecked
                dailyTaskViewModel.goalState = true
            }
            self.reloadData()
            //            congratsMessage(title: "Congratulations", message: "You have completed your Goal for today.")
        } else { // if goal false tasks revert to previouse state
            var rowIndex = 0
            rowCell.forEach { (row) in
                let indexPath = IndexPath(row: rowIndex, section: 0)
                if (row as! TableViewCell).isPreviouseState == true {
                    dailyTaskViewModel.goalState = true
                } else {
                    dailyTaskViewModel.goalState = false
                    self.reloadRows(at: [indexPath], with: .none)
                }
                rowIndex += 1
            }
        }
    }
}
