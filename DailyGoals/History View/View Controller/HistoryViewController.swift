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
    
    var dic:[String: String] = ["date": "", "goal":  "", "task": ""]
    
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
        
        if CoreDataManager.shared.fetchGoalData() != nil {
//
//            dailyTasksTableView.tableSectionName = CoreDataManager.shared.fetchIndividualData(savedObject: "goal")!
//
//            print ("goals \(CoreDataManager.shared.fetchIndividualData(savedObject: "goal")!)")
//
//            print ("tasks \([CoreDataManager.shared.fetchIndividualData(savedObject: "task1")!, CoreDataManager.shared.fetchIndividualData(savedObject: "task2")!, CoreDataManager.shared.fetchIndividualData(savedObject: "task3")!])")
//
////            dailyTasksTableView.tableCellData = [CoreDataManager.shared.fetchIndividualData(savedObject: "task1")!, CoreDataManager.shared.fetchIndividualData(savedObject: "task2")!, CoreDataManager.shared.fetchIndividualData(savedObject: "task3")!]
//            dailyTasksTableView.tableCellData.append(CoreDataManager.shared.fetchIndividualData(savedObject: "task1")!)
//            dailyTasksTableView.tableCellData.append(CoreDataManager.shared.fetchIndividualData(savedObject: "task2")!)
//            dailyTasksTableView.tableCellData.append(CoreDataManager.shared.fetchIndividualData(savedObject: "task3")!)
//
//        }
        
        let test = CoreDataManager.shared.fetchGoalData()
        
        for i in test! {
            
            dailyTasksTableView.tableSectionName = [DailyGoalData(text: i.goal)]
            
//            dailyTasksTableView.tableCellData = [i.task1, i.task2, i.task3]
            print (i.date)
        }
    }
    }
    
//    func checkCoreData() {//if todays data exists then go straight to table, if not show alertbox
//        let checkToday = CoreDataManager.shared.fetchGoalDataForToday(date: todaysDate)
//        if (checkToday?.count)! > 0 {
//            for savedData in checkToday! {
//                //Update text in section and rows
//                dailyTaskTableView.sectionData = [DailyGoalData(text: savedData.goal)]
//                let taskArray = [savedData.task1, savedData.task2, savedData.task3]
//                for index in 0 ..< taskArray.count {
//                    dailyTaskTableView.cellsData[index] = CellData(text: taskArray[index])
//                }
//                //update checkboxes
//                let taskCompleteArray = [savedData.task1Complete, savedData.task2Complete, savedData.task3Complete]
//                for index in 0 ..< taskCompleteArray.count {
//                    if taskCompleteArray[index] {
//                        dailyTaskTableView.selectRow(at: NSIndexPath(row: index, section: 0) as IndexPath, animated: true, scrollPosition: .middle)
//                        dailyTaskTableView.delegate?.tableView!(dailyTaskTableView, didSelectRowAt: NSIndexPath(row: index, section: 0) as IndexPath)
//                    }
//                }
//            }
//        } else {
//            initialAlertBox()
//        }
//    }
    
    func assignDependencies(historyViewModel: HistoryViewModel, historyFlow: HistoryFlow) {
        self.historyFlow = historyFlow
        self.historyViewModel = historyViewModel
        
        
    }
}

