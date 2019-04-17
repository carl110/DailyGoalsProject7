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
    
    var gif = UIImageView()
    var gifButton = UIButton()
    
    var cellsData: [CellData] = []
    var sectionData:[DailyGoalData] = []
    
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
        return sectionData.count
    }
    
    //Number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.count
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
        cell.config(task: cellsData[indexPath.row])
        cell.checkBox.checkBoxDelegate = self
        cell.checkBox.owner = .Task
        return cell
    }
    
    //what to do when row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        //Set thaskcomplete marker in core data
        let taskComplete = indexPath.row + 1
        if cell.checkBox.isChecked {
            CoreDataManager.shared.update(object: "task\(taskComplete)Complete", updatedEntry: false, date: dailyTaskViewModel.todaysDate)
//            let updatedData = CoreDataManager.shared.fetchGoalData()
//            dump(updatedData)
        } else {
            CoreDataManager.shared.update(object: "task\(taskComplete)Complete", updatedEntry: true, date: dailyTaskViewModel.todaysDate)
//            let updatedData = CoreDataManager.shared.fetchGoalData()
//            dump(updatedData)
        }
        
        //set previouse state
        self.visibleCells.forEach{ (cell) in
            (cell as! TableViewCell).isPreviouseState = (cell as! TableViewCell).checkBox.isChecked
        }
        cell.toggle()
        
        //check if any task cell is false
        if cell.isToggled == false {
            dailyTaskViewModel.taskState = nil
            let header = tableView.headerView(forSection: 0) as! CustomHeader
            header.checkBox.isChecked = false

            //Display animated GIF
            gif = UIImageView(image: UIImage.gif(name: "keepGoingBackwards"))
            gif.frame.size = findViewController()!.view.frame.size
            gif.center = findViewController()!.view.center

            self.findViewController()!.view.addSubview(gif)
            addGifButton()
            findViewController()!.alertBoxWithTimer(title: "Thats a shame", message: "Keep going you will get there.", timeDelay: 2.0)
        } else {
                    allCellsTrue(rows: self.visibleCells)
        }

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
            
            //Display animated GIF
            gif = UIImageView(image: UIImage.gif(name: "fireworks"))
            gif.frame.size = findViewController()!.view.frame.size
            gif.center = findViewController()!.view.center
            
            self.findViewController()!.view.addSubview(gif)
            addGifButton()
            findViewController()!.alertBoxWithTimer(title: "CONGRATULATIONS", message: "Well done on completing your Daily Goal", timeDelay: 3.5)
        }
        if trueCount < rows.count {

            //Display animated GIF
            gif = UIImageView(image: UIImage.gif(name: "keepGoing"))
            gif.frame.size = findViewController()!.view.frame.size
            gif.center = findViewController()!.view.center

            self.findViewController()!.view.addSubview(gif)
            addGifButton()
            
            if rows.count - trueCount == 1 {
                            findViewController()!.alertBoxWithTimer(title: "You're almost there", message: "Two tasks down, only one task left to complete", timeDelay: 3.0)
            } else {
                            findViewController()!.alertBoxWithTimer(title: "You're almost there", message: "Only \(rows.count - trueCount) more tasks to complete", timeDelay: 3.0)
            }
            

//                        congratsMessage(title: "You're almost there", message: "Only \(rows.count - trueCount) more tasks to complete")
        }
    }
    
    func headerSectionCell(_ cell: CustomHeader) {
        //if goal is true then all tasks true
        let rowCell = self.visibleCells
        if cell.checkBox.isChecked == true {
            //set previouse state to checkboxState
            rowCell.forEach{ (row) in
                (row as! TableViewCell).isPreviouseState = (row as! TableViewCell).checkBox.isChecked
                dailyTaskViewModel.taskState = true
            }
            
            CoreDataManager.shared.update(object: "task1Complete", updatedEntry: true, date: dailyTaskViewModel.todaysDate)
            CoreDataManager.shared.update(object: "task2Complete", updatedEntry: true, date: dailyTaskViewModel.todaysDate)
            CoreDataManager.shared.update(object: "task3Complete", updatedEntry: true, date: dailyTaskViewModel.todaysDate)

            self.reloadData()

            //Display animated GIF
            gif = UIImageView(image: UIImage.gif(name: "fireworks"))
            gif.frame.size = findViewController()!.view.frame.size
            gif.center = findViewController()!.view.center
            
            self.findViewController()!.view.addSubview(gif)
            addGifButton()
            findViewController()!.alertBoxWithTimer(title: "CONGRATULATIONS", message: "Well done on completing your Daily Goal", timeDelay: 2.0)
            
            
            
        } else { // if goal false tasks revert to previouse state
            var rowIndex = 0
            var taskComplete = 1

            //Display animated GIF
            gif = UIImageView(image: UIImage.gif(name: "keepGoingBackwards"))
            gif.frame.size = findViewController()!.view.frame.size
            gif.center = findViewController()!.view.center
            
            self.findViewController()!.view.addSubview(gif)
            addGifButton()
            findViewController()!.alertBoxWithTimer(title: "Thats a shame", message: "Keep going you will get there.", timeDelay: 2.0)
            
            rowCell.forEach { (row) in
                let indexPath = IndexPath(row: rowIndex, section: 0)
                if (row as! TableViewCell).isPreviouseState == true {
                    dailyTaskViewModel.taskState = true
                } else {
                    dailyTaskViewModel.taskState = false
                    self.reloadRows(at: [indexPath], with: .none)
                    CoreDataManager.shared.update(object: "task\(taskComplete)Complete", updatedEntry: false, date: dailyTaskViewModel.todaysDate)
                }
                rowIndex += 1
                taskComplete += 1
            }
        }
    }
    
    func testMessage() {
        //Display animated GIF
        gif = UIImageView(image: UIImage.gif(name: "keepGoingBackwards"))
        gif.frame.size = findViewController()!.view.frame.size
        gif.center = findViewController()!.view.center
        
        self.findViewController()!.view.addSubview(gif)
        addGifButton()
        findViewController()!.alertBoxWithTimer(title: "Thats a shame", message: "Keep going you will get there.", timeDelay: 2.0)
    }
    
    func addGifButton() {
        gifButton.frame.size = findViewController()!.view.frame.size
        gifButton.isOpaque = true
        gifButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        findViewController()!.view.addSubview(gifButton)
    }
    
    @objc func buttonAction(sender: UIButton) {
        gif.removeFromSuperview()
        gifButton.removeFromSuperview()
    }
}
