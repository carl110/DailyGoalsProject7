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

    var cellsData: [CellData] = []
    var sectionData:[DailyGoalData] = [DailyGoalData(text: "")]
    var sectionExpanded = true
    
    @IBOutlet weak var dailyTaskTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetUp()
        initialAlertBox()
    }
    
    func tableSetUp() {
        //delegate and datasource for table
        dailyTaskTableView.delegate = self
        dailyTaskTableView.dataSource = self
        //call custom cell
        dailyTaskTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        dailyTaskTableView.estimatedRowHeight = 100
        dailyTaskTableView.rowHeight = UITableView.automaticDimension
        //call custom header
        let headerNib = UINib.init(nibName: "CustomHeader", bundle: Bundle.main)
        dailyTaskTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "CustomHeader")
        dailyTaskTableView.sectionHeaderHeight = UITableView.automaticDimension
        dailyTaskTableView.estimatedSectionHeaderHeight = 80
        //hide unused rows
        dailyTaskTableView.tableFooterView = UIView()
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
                                
                                self.warningMessage()

                            } else {
                                self.sectionData = [DailyGoalData(text: "\(Date().string(format: "dd MMM yyyy")) \n \(goalInput ?? "")")]
                                self.cellsData = [CellData(text: "\(task1Input ?? "")" ),
                                                  CellData(text: "\(task2Input ?? "")" ),
                                                  CellData(text: "\(task3Input ?? "")" )]
                                self.dailyTaskTableView.reloadData()
                            }
        })
    }
    
    func warningMessage() {
        let alert = UIAlertController(title: "Goals and Tasks", message: "You must complete setails for the goal and all 3 tasks", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            self.initialAlertBox()
        }))
       present(alert, animated: true, completion: nil)
        
    }
    
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
        self.dailyTaskViewModel = dailyTaskViewModel
    }
}
