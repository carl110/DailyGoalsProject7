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

    @IBOutlet weak var dailyTaskTableView: CustomTable!
    
    @IBOutlet weak var editTasks: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialAlertBox()
        DispatchQueue.main.async {
            self.editTaskButtonSetUp()
        }
    }
    
    @IBAction func editTasks(_ sender: Any) {
        let tableHeader = (dailyTaskTableView.headerView(forSection: 0) as! CustomHeader)
        let rowCell = dailyTaskTableView.visibleCells
        
        //check state of labelTitle
        if tableHeader.labelTitle.isEnabled == false {
        
            //enable edit for goal and tasks and change background colours
            tableHeader.labelTitle.isEnabled = true

            tableHeader.backgroundColor = UIColor.Shades.standardWhite
            rowCell.forEach{ (row) in
                (row as! TableViewCell).label.isEnabled = true
                (row as! TableViewCell).label.backgroundColor = UIColor.Shades.standardWhite
            }
            
            //update title on button
            editTasks.setTitle("Save Changes", for: UIControl.State.normal)
        
        } else { //stop editing of text buttons
            tableHeader.labelTitle.isEnabled = false

//
//            CoreDataManager.shared.update(goal: tableHeader.textLabel?.text ?? "No new value", date: todaysDate)

            tableHeader.backgroundColor = UIColor.clear
            
            //Update array for header
            dailyTaskTableView.sectionData = [DailyGoalData(text: tableHeader.labelTitle.text!)]
            
            //update array for tableCells
            for i in 0 ... dailyTaskTableView.visibleCells.endIndex - 1 {
                let cell: TableViewCell = dailyTaskTableView.cellForRow(at: NSIndexPath(row: i, section: 0) as IndexPath) as! TableViewCell
                dailyTaskTableView.cellsData[i] = CellData(text: cell.label.text ?? "No Value")
            }
            
            rowCell.forEach{ (row) in
                (row as! TableViewCell).label.isEnabled = false
                (row as! TableViewCell).label.backgroundColor = UIColor.clear
                
                
//                self.update(taskData: (rowCell.t textLabel?.text)!, dailyGoal: DailyGoal.self as! DailyGoal)
//                CoreDataManager.shared.updateGoalData(taskData: (row as! TableViewCell).label.text!, date: NSDate())
            }

            editTasks.setTitle("Edit Tasks", for: .normal)
            
//            CoreDataManager.shared.updateGoalData(taskData: tableHeader.labelTitle.text!, date: NSDate())

        }
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
                                                            print("option: \(option)")
                                                            switch(option) {
                                                            case 0:
                                                                self.initialAlertBox()
                                                            default:
                                                                break
                                                            }
                                }
                            } else { //append data from alertbox to arrays
                                self.dailyTaskTableView.sectionData = [DailyGoalData(text: "\(self.todaysDate) \n \(goalInput ?? "")")]
                                self.dailyTaskTableView.cellsData = [CellData(text: "\(task1Input ?? "")" ),
                                                                     CellData(text: "\(task2Input ?? "")" ),
                                                                     CellData(text: "\(task3Input ?? "")" )]
                                self.dailyTaskTableView.reloadData()
                                
                                CoreDataManager.shared.saveGoalData(goal: "\(self.todaysDate) \n \(goalInput!)", task1: task1Input!, task2: task2Input!, task3: task3Input!, date: self.todaysDate)
                                
                            }
        })
        
        
    }
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
//        self.dailyTaskViewModel = dailyTaskViewModel
    }
}
