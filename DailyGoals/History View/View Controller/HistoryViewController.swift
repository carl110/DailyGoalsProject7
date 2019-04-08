//
//  HistoryViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    private var historyViewModel: HistoryViewModel!
    private var historyFlow: HistoryFlow!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dailyTasksTableView: HistoryTable!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelSetUp()
        savedData()
    }
    
    func titleLabelSetUp() {
        titleLabel.titleLabelFormat(colour: UIColor.Greens.standardGreen)
        titleLabel.text = "History"
    }
    
    func savedData() {
        //Clear the arrays
        dailyTasksTableView.tableSectionName.removeAll()
        dailyTasksTableView.tableCellData.removeAll()
        dailyTasksTableView.taskCompletetion.removeAll()
        
        //Only run if there is saved data
        if CoreDataManager.shared.fetchGoalData() != nil {
            
            let test = CoreDataManager.shared.fetchGoalData()

            //for each entry on CoreData append to correct array
            for i in test! {
                
                if i.task1Complete == true && i.task2Complete == true && i.task3Complete == true {
                    dailyTasksTableView.tableSectionName.append("\(i.date) \(i.goal) - Complete")
                } else {
                    dailyTasksTableView.tableSectionName.append("\(i.date) \(i.goal) - Not Complete")
                }

                dailyTasksTableView.tableCellData.append([i.task1, i.task2, i.task3])
                dailyTasksTableView.taskCompletetion.append([i.task1Complete, i.task2Complete, i.task3Complete])
                }
            
            print ("tableCellData \(dailyTasksTableView.tableCellData)")
            
            print ("tableSectionData \(dailyTasksTableView.tableSectionName)")
            
            print ("TaskComplete \(dailyTasksTableView.taskCompletetion)")
            


            //remove entry for todays goal
            if dailyTasksTableView.tableSectionName.count > 0 {
            dailyTasksTableView.tableSectionName.removeLast()
            dailyTasksTableView.tableCellData.removeLast()
                dailyTasksTableView.taskCompletetion.removeLast()
            }
        }
    }
   
    func assignDependencies(historyViewModel: HistoryViewModel, historyFlow: HistoryFlow) {
        self.historyFlow = historyFlow
        self.historyViewModel = historyViewModel
    }
}

