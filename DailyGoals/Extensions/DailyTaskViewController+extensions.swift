//
//  DailyTaskViewController+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 28/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension DailyTaskViewController: UITableViewDataSource, UITableViewDelegate, CheckBoxDelegate, HeaderSectionDelegate {
    

    
    func checkBoxDidClick(owner: CheckBox.CheckBoxOwner, state: Bool) {
    }
    
    //Number of section required for table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionExpanded == true ? cellsData.count : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
        headerView.checkBox.checkBoxDelegate = self
        headerView.checkBox.owner = .Goal
        headerView.config(goal: sectionData[section])
        headerView.tag = section
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.config(task: cellsData[indexPath.row], checkBoxState: goalState)
        cell.checkBox.checkBoxDelegate = self
        cell.checkBox.owner = .Task
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.toggle()
        //check if any task cell is false
        if cell.isToggled == false {
            goalState = nil
            let header = tableView.headerView(forSection: 0) as! CustomHeader
            header.checkBox.isChecked = false
        }
        //Check if all tasks cells are true
        let cells = dailyTaskTableView.visibleCells
        var trueCount = 0
        cells.forEach { (cell) in
            if (cell as! TableViewCell).isToggled == true {
                trueCount += 1
            }
        }
        let header = dailyTaskTableView.headerView(forSection: 0) as! CustomHeader
        if trueCount == cells.count {
            header.checkBox.isChecked = true
        }
    }
    
    func headerSectionCell(_ cell: CustomHeader) {
        //if goal is true then all tasks true
        let rowCell = dailyTaskTableView.visibleCells
        if cell.checkBox.isChecked == true {
            //set previouse state to checkboxState
            rowCell.forEach{ (row) in
                (row as! TableViewCell).isPreviouseState = (row as! TableViewCell).checkBox.isChecked
            }
            goalState = true
            dailyTaskTableView.reloadData()
        } else { // if goal false tasks revert to previouse state
            var rowIndex = 0
            rowCell.forEach { (row) in
                let indexPath = IndexPath(row: rowIndex, section: 0)
                goalState = (row as! TableViewCell).isPreviouseState
                dailyTaskTableView.reloadRows(at: [indexPath], with: .fade)
                rowIndex += 1
            }
            
        }
        
    }
}
