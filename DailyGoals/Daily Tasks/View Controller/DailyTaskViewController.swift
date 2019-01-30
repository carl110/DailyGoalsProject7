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

    var cellsData: [CellData] = []
    var sectionData:[DailyGoalData] = [DailyGoalData(text: "")]
    var sectionExpanded = true
    
    @IBOutlet weak var dailyTaskTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate and datasource for table
        dailyTaskTableView.delegate = self
        dailyTaskTableView.dataSource = self
        //call custom cell
        dailyTaskTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        //call custom header
        let headerNib = UINib.init(nibName: "CustomHeader", bundle: Bundle.main)
        dailyTaskTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "CustomHeader")
        dailyTaskTableView.sectionHeaderHeight = UITableView.automaticDimension
        dailyTaskTableView.estimatedSectionHeaderHeight = 80
        dailyTaskTableView.estimatedRowHeight = 50
        dailyTaskTableView.rowHeight = UITableView.automaticDimension
        //Alert box to ad new goal and tasks
        showGoalTaskDialog(title: "Todays Goal ",
                           subtitle: "Please enter your goal for today, and the 3 tasks to achieve your goal",
                           actionTitle: "Add new Goal and Tasks",
                           goalPlaceHolder: "Input your goal here...",
                           task1PlaceHolder: "Input task one here...",
                           task2PlaceHolder: "Input task two here...",
                           task3PlaceHolder: "Input task three here...")
        { (goalInput:String?, task1Input:String?, task2Input:String?, task3Input:String?) in
            self.sectionData = [DailyGoalData(text: "\(Date().string(format: "dd MMM yyyy")) \n \(goalInput ?? "")")]
            self.cellsData = [CellData(text: "\(task1Input ?? "")" ),
                              CellData(text: "\(task2Input ?? "")" ),
                              CellData(text: "\(task3Input ?? "")" )]
            self.dailyTaskTableView.reloadData()
        }
    }
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
        self.dailyTaskViewModel = dailyTaskViewModel
    }
}
