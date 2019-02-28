//
//  ViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class DailyTaskViewController: UIViewController {
    
    fileprivate var dailyTaskFlow: DailyTaskFlow!
    fileprivate var dailyTaskViewModel: DailyTaskViewModel!
    fileprivate var dailyTaskData: CellData!
    fileprivate var dailyGoalData: DailyGoalData!
    
    @IBOutlet weak var dailyTaskTableView: CustomTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialAlertBox()
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
                                self.dailyTaskTableView.sectionData = [DailyGoalData(text: "\(Date().string(format: "dd MMM yyyy")) \n \(goalInput ?? "")")]
                                self.dailyTaskTableView.cellsData = [CellData(text: "\(task1Input ?? "")" ),
                                                                     CellData(text: "\(task2Input ?? "")" ),
                                                                     CellData(text: "\(task3Input ?? "")" )]
                                self.dailyTaskTableView.reloadData()
                            }
        })
    }
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
        self.dailyTaskViewModel = dailyTaskViewModel
    }
}
