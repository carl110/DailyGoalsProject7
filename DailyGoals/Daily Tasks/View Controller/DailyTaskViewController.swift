//
//  ViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit
import CoreData

class DailyTaskViewController: UIViewController {
    
    fileprivate var dailyTaskFlow: DailyTaskFlow!
    fileprivate var dailyTaskViewModel: DailyTaskViewModel!
    fileprivate var dailyTaskData: CellData!
    fileprivate var dailyGoalData: DailyGoalData!
    
    let todaysDate = Date().string(format: "dd MMM yyyy")

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dailyTaskTableView: CustomTable!
    
    @IBOutlet weak var editTasks: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTitle()
//        initialAlertBox()
        DispatchQueue.main.async {
            self.editTaskButtonSetUp()
        }
        checkCoreData()
        
    }
    
    func checkCoreData() {//if todays data exists then go straight to table, if not show alertybox
        let checkToday = CoreDataManager.shared.fetchGoalDataForToday(date: todaysDate)
        
        if (checkToday?.count)! > 0 {
         
            for i in checkToday! {
                dailyTaskTableView.sectionData = [DailyGoalData(text: i.goal)]
                
                dailyTaskTableView.cellsData[0] = CellData(text: i.task1)
                dailyTaskTableView.cellsData[1] = CellData(text: i.task2)
                dailyTaskTableView.cellsData[2] = CellData(text: i.task3)
                
                
                if i.task1Complete == true {
                    dailyTaskTableView.selectRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, animated: true, scrollPosition: .middle)
                    dailyTaskTableView.delegate?.tableView!(dailyTaskTableView, didSelectRowAt: NSIndexPath(row: 0, section: 0) as IndexPath)
                }
                if i.task2Complete == true {
                    dailyTaskTableView.selectRow(at: NSIndexPath(row: 1, section: 0) as IndexPath, animated: true, scrollPosition: .middle)
                    dailyTaskTableView.delegate?.tableView!(dailyTaskTableView, didSelectRowAt: NSIndexPath(row: 1, section: 0) as IndexPath)
                }
                if i.task3Complete == true {
                    dailyTaskTableView.selectRow(at: NSIndexPath(row: 2, section: 0) as IndexPath, animated: true, scrollPosition: .middle)
                    dailyTaskTableView.delegate?.tableView!(dailyTaskTableView, didSelectRowAt: NSIndexPath(row: 2, section: 0) as IndexPath)
                }
            }
        } else {
            initialAlertBox()
        }
    }
    
    func setUpTitle() {
        titleLabel.titleLabelFormat(colour: UIColor.Blues.lightBlue)
        titleLabel.text = "Daily Tasks"
    }

    @IBAction func editTasks(_ sender: Any) {
        let tableHeader = (dailyTaskTableView.headerView(forSection: 0) as! CustomHeader)
        let rowCell = dailyTaskTableView.visibleCells

        //check state of labelTitle
        if tableHeader.labelTitle.isEnabled == false {
        editTableData()
        } else {
            
            rowCell.forEach{ (row) in
                if (tableHeader.labelTitle.text?.isEmpty)! || ((row as! TableViewCell).label.text?.isEmpty)! {
                    
                    alertBoxWithAction(title: "Incomplete Data", message: "You cannot leave any of the tasks or goal blank, please complete these fully to proceed.", options: "Complete Data") { (option) in
                        switch(option) {
                            case 0:
                                self.editTableData()
                        default:
                            break
                        }
                    }
                }
            }
            saveTableData()
        }
    }
    
    func editTableData() {
        let tableHeader = (dailyTaskTableView.headerView(forSection: 0) as! CustomHeader)
        let rowCell = dailyTaskTableView.visibleCells
            //enable edit for goal and tasks and change background colours
            tableHeader.labelTitle.isEnabled = true
            tableHeader.backgroundColor = UIColor.Shades.standardWhite
            rowCell.forEach{ (row) in
                (row as! TableViewCell).label.isEnabled = true
                (row as! TableViewCell).label.backgroundColor = UIColor.Shades.standardWhite
            }
            
            //update title on button
            editTasks.setTitle("Save Changes", for: UIControl.State.normal)
    }
        
        func saveTableData() {
            let tableHeader = (dailyTaskTableView.headerView(forSection: 0) as! CustomHeader)
            let rowCell = dailyTaskTableView.visibleCells
            tableHeader.labelTitle.isEnabled = false
            tableHeader.backgroundColor = UIColor.clear
            
            //Update array for header and the coredata
            dailyTaskTableView.sectionData = [DailyGoalData(text: tableHeader.labelTitle.text!)]
            CoreDataManager.shared.update(object: "goal", updatedEntry: tableHeader.labelTitle.text!, date: todaysDate)
            
            //update array for tableCells and coredata for tasks
            for i in 0 ... dailyTaskTableView.visibleCells.endIndex - 1 {
                let cell: TableViewCell = dailyTaskTableView.cellForRow(at: NSIndexPath(row: i, section: 0) as IndexPath) as! TableViewCell
                dailyTaskTableView.cellsData[i] = CellData(text: cell.label.text ?? "No Value")
                let taskNumber = "task\(i + 1)"
                CoreDataManager.shared.update(object: taskNumber, updatedEntry: cell.label.text! as String, date: todaysDate)
            }
            
            rowCell.forEach{ (row) in
                (row as! TableViewCell).label.isEnabled = false
                (row as! TableViewCell).label.backgroundColor = UIColor.clear
            }
            editTasks.setTitle("Edit Tasks", for: .normal)
            
            //print table data to check
            let updatedData = CoreDataManager.shared.fetchGoalData()
            dump(updatedData)
        }
    
    func editTaskButtonSetUp() {
        editTasks.setTitle("Edit Tasks", for: UIControl.State.normal)
        editTasks.roundCorners(for: .allCorners, cornerRadius: 8)
        editTasks.centerTextHorizontally(spacing: 1)
        editTasks.backgroundColor = UIColor.Blues.softBlue
    }
    
    func initialAlertBox() {
        //Alert box to add new goal and tasks
        showGoalTaskDialog(title: "Todays Goal ",
                           subtitle: "Please enter your goal for today, and the 3 tasks to achieve your goal",
                           actionTitle: "Add new Goal and Tasks",
                           goalPlaceHolder: "Input your goal here...",
                           task1PlaceHolder: "Input task one here...",
                           task2PlaceHolder: "Input task two here...",
                           task3PlaceHolder: "Input task three here...",
                           actionHandler: { (goalInput:String?, task1Input:String?, task2Input:String?, task3Input:String?) in
                            
                            if (goalInput?.isEmpty)! || (task1Input?.isEmpty)! || (task2Input?.isEmpty)! || (task3Input?.isEmpty)! {
                                //Alert reruns initial alert
                                self.alertBoxWithAction(title: "Goals and Tasks",
                                                        message: "You must complete setails for the goal and all 3 tasks",
                                                        options: "Complete Inputs") { (option) in
                                                            switch(option) {
                                                            case 0:
                                                                self.initialAlertBox()
                                                            default:
                                                                break
                                                            }
                                }
                            } else { //append data from alertbox to arrays
                                self.dailyTaskTableView.sectionData = [DailyGoalData(text: "\(goalInput ?? "")")]
                                self.dailyTaskTableView.cellsData = [CellData(text: "\(task1Input ?? "")" ),
                                                                     CellData(text: "\(task2Input ?? "")" ),
                                                                     CellData(text: "\(task3Input ?? "")" )]
                                self.dailyTaskTableView.reloadData()
                                
                                CoreDataManager.shared.saveGoalData(goal: "\(goalInput!)", task1: task1Input!, task2: task2Input!, task3: task3Input!, date: self.todaysDate, task1Complete: false)
                                
                            }
        })
        
        
    }
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
    }
}
