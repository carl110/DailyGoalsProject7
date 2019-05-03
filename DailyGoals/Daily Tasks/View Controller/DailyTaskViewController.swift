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
    fileprivate var dailyTaskViewModel = DailyTaskViewModel()
    fileprivate var dailyTaskData: CellData!
    fileprivate var dailyGoalData: DailyGoalData!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dailyTaskTableView: CustomTable!
    @IBOutlet weak var editTasks: UIButton!
    
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTitle()
        //Dispatch required for all corners to round before appearing
        DispatchQueue.main.async { [weak self] in
            self!.editTaskButtonSetUp()
        }
        checkIfAnyPreviouseTasks()
        hideKeyboardWhenTappedAround()
    }
    
    func setUpTitle() {
        titleLabel.titleLabelFormat(colour: UIColor.Blues.lightBlue)
        titleLabel.text = "Daily Tasks"
    }
    
    func editTaskButtonSetUp() {
        editTasks.setTitle("Edit Tasks", for: UIControl.State.normal)
        editTasks.roundCorners(for: .allCorners, cornerRadius: 8)
        editTasks.centerTextHorizontally(spacing: 1)
        editTasks.backgroundColor = UIColor.Blues.softBlue
    }
    
    //Check if there are any previouse tasks and assign data or show alertbox
    func checkIfAnyPreviouseTasks() {
        dailyTaskViewModel.checkCoreData()
        if dailyTaskViewModel.runPreviouseTaskAlert == true {
            previouseAlert()
        } else if dailyTaskViewModel.sectionData.isEmpty {
            initialAlertBox()
        } else {
            dailyTaskTableView.sectionData = dailyTaskViewModel.sectionData
            dailyTaskTableView.cellsData = dailyTaskViewModel.cellsData
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
        CoreDataManager.shared.update(object: "goal", updatedEntry: tableHeader.labelTitle.text!, date: dailyTaskViewModel.todaysDate)
        
        //update array for tableCells and coredata for tasks
        for index in 0 ... dailyTaskTableView.visibleCells.endIndex - 1 {
            let cell: TableViewCell = dailyTaskTableView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath) as! TableViewCell
            dailyTaskTableView.cellsData[index] = CellData(text: cell.task.text, state: cell.task.state)
            let taskNumber = "task\(index + 1)"
            CoreDataManager.shared.update(object: taskNumber, updatedEntry: cell.label.text! as String, date: dailyTaskViewModel.todaysDate)
        }
        
        rowCell.forEach{ (row) in
            (row as! TableViewCell).label.isEnabled = false
            (row as! TableViewCell).label.backgroundColor = UIColor.clear
        }
        editTasks.setTitle("Edit Tasks", for: .normal)
    }
    
    func previouseAlert() {
        
        //alertbox showing previouse tasks
        let checkPreviouseGoal = CoreDataManager.shared.fetchGoalDataForDate(date: Date().subtract(days: dailyTaskViewModel.daySubtraction)!.string(format: "dd MM yyyy"))
        for date in checkPreviouseGoal! {
            alertBoxWithAction(title: "You have a previously incomplete task",
                               message: "Your previouse goal was \(date.goal), with tasks - \n \(date.task1) \n \(date.task2) \n \(date.task3)", options: AlertBox.usePreviouseGoal.name(), AlertBox.enterNewGoalAndTasks.name()) { (option) in
                                switch(option) {
                                case AlertBox.usePreviouseGoal.name():
                                    self.dailyTaskViewModel.usePreviouseGoal()
                                    self.dailyTaskTableView.sectionData = self.dailyTaskViewModel.sectionData
                                    self.dailyTaskTableView.cellsData = self.dailyTaskViewModel.cellsData
                                    self.dailyTaskTableView.reloadData()
                                case AlertBox.enterNewGoalAndTasks.name():
                                    self.initialAlertBox()
                                    
                                default:
                                    break
                                }
            }
        }
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
                                                            case "Complete Inputs":
                                                                self.initialAlertBox()
                                                            default:
                                                                break
                                                            }
                                }
                            } else { //append data from alertbox to arrays
                                self.dailyTaskTableView.sectionData = [DailyGoalData(text: "\(goalInput ?? "")")]
                                self.dailyTaskTableView.cellsData = [CellData(text: "\(task1Input ?? "")", state: false ),
                                                                     CellData(text: "\(task2Input ?? "")", state: false),
                                                                     CellData(text: "\(task3Input ?? "")", state: false )]
                                self.dailyTaskTableView.reloadData()
                                
                                CoreDataManager.shared.saveGoalData(goal: "\(goalInput!)", task1: task1Input!, task2: task2Input!, task3: task3Input!, date: self.dailyTaskViewModel.todaysDate)
                            }
        })
    }
    
    @IBAction func editTasks(_ sender: Any) {
        let tableHeader = (dailyTaskTableView.headerView(forSection: 0) as! CustomHeader)
        let rowCell = dailyTaskTableView.visibleCells
        
        //check state of labelTitle
        if tableHeader.labelTitle.isEnabled == false {
            editTableData()
        } else {
            
            rowCell.forEach { (row) in
                if (tableHeader.labelTitle.text?.isEmpty)! || ((row as! TableViewCell).label.text?.isEmpty)! {
                    
                    alertBoxWithAction(title: "Incomplete Data", message: "You cannot leave any of the tasks or goal blank, please complete these fully to proceed.", options: AlertBox.completeData.rawValue.titlecased()) { (option) in
                        switch(option) {
                        case AlertBox.completeData.name():
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
}
