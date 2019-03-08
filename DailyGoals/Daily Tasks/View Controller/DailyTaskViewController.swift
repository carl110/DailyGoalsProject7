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
    //setup for coreData
//    var goalItem = [DailyGoal]()
//    var context:NSManagedObjectContext!
//    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var dailyTaskTableView: CustomTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialAlertBox()
        
//        context = appDelegate?.persistentContainer.viewContext
        
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
                                
                                
                                CoreDataManager.shared.saveGoalData(goal: goalInput!, task1: task1Input!, task2: task2Input!, task3: task3Input!, date: NSDate())
                                
                                
//                                //save to coredata
//                                let goal = DailyGoal(context: self.context)
//
//                                goal.setValue(goalInput, forKey: "goal")
//                                goal.setValue(task1Input, forKey: "task1")
//                                goal.setValue(task2Input, forKey: "task2")
//                                goal.setValue(task3Input, forKey: "task3")
//                                goal.setValue(NSDate(), forKey: "date")
//
//                                self.appDelegate?.saveContext()
//
                            }
        })
    }
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
//        self.dailyTaskViewModel = dailyTaskViewModel
    }
}
