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
    
    var trueCount = 0
    var goalCompleteCount = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var historyTableView: HistoryTable!
    @IBOutlet weak var monthPickerView: MonthPickerView!
    @IBOutlet weak var monthPickerButton: UIButton!
    @IBOutlet weak var monthSummaryLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelSetUp()
        allSavedData()
        monthPickerViewSetUp()
        monthPickerButtonSetUp()
    }
    
    @IBAction func monthPickerButton(_ sender: Any) {
        print (monthPickerView.selectedRow(inComponent: 0))
        
        //Clear the arrays
        historyTableView.tableSectionName.removeAll()
        historyTableView.tableCellData.removeAll()
        historyTableView.taskCompletetion.removeAll()
        
        //Only run if there is saved data
        if CoreDataManager.shared.fetchGoalData() != nil {
            if monthPickerView.selectedRow(inComponent: 0) == 12 {
                allSavedData()
            } else {
                dataByMonth()
            }
        }
        historyTableView.reloadData()
    }
    
    func titleLabelSetUp() {
        titleLabel.titleLabelFormat(colour: UIColor.Greens.seaGreen)
        titleLabel.text = "History"
    }
    
    func monthPickerButtonSetUp() {
 
        monthPickerButton.roundCorners(for: [.topRight, .bottomRight], cornerRadius: 8)
        monthPickerButton.centerTextHorizontally(spacing: 2)
        monthPickerButton.setTitle("Select", for: .normal)
        monthPickerButton.backgroundColor = UIColor.Greens.seaGreen
        monthPickerButton.setTitleColor(UIColor.Shades.standardWhite, for: .normal)
//        monthPickerButton.titleLabel?.textColor = UIColor.Shades.standardWhite
        monthPickerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func monthPickerViewSetUp() {
        monthPickerView.backgroundColor = UIColor.Greens.seaGreen
            self.monthPickerView.roundCorners(for: [.topLeft, .bottomLeft], cornerRadius: 8)
    }
    
    func allSavedData() {
        //reset trueCount number
        trueCount = 0
        goalCompleteCount = 0
        
        //fecth all saved data
        let fetchedData = CoreDataManager.shared.fetchGoalData()
        
        //for each entry on CoreData append to correct array
        for i in fetchedData! {
            
            let taskCompleteArray = [i.task1Complete, i.task2Complete, i.task3Complete]
            
            if i.task1Complete == true && i.task2Complete == true && i.task3Complete == true {
                historyTableView.tableSectionName.append("\(i.date) \(i.goal) - Complete")
                goalCompleteCount += 1
            } else {
                historyTableView.tableSectionName.append("\(i.date) \(i.goal) - Not Complete")
            }
            historyTableView.tableCellData.append([i.task1, i.task2, i.task3])
            historyTableView.taskCompletetion.append(taskCompleteArray)
            
            for i in taskCompleteArray {
                if i == true {
                    trueCount += 1
                }
            }
            monthSummaryLabel.text = "For the history of the App. \n You have completed \(goalCompleteCount) out of \(historyTableView.tableSectionName.count) Goals with \(trueCount) out of \(historyTableView.taskCompletetion.count * 3) tasks being completed."
        }
        
        historyTableView.tableSectionName.removeLast()
        historyTableView.tableCellData.removeLast()
        historyTableView.taskCompletetion.removeLast()
        
    }
    
    func dataByMonth() {
        
        trueCount = 0
        goalCompleteCount = 0
        let index = monthPickerView.selectedRow(inComponent: 0)
        //set aray for month number
        let dateArray = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        
        for i in 1...31 {
            //Format to ensure 2 digit number
            let date = "\(String(format: "%02d", i)) \(dateArray[index]) 2019"
            //fecth data for each day in the selected month
            let fetchedData = CoreDataManager.shared.fetchGoalDataForToday(date: date)
            //for each entry on CoreData append to correct array
            for i in fetchedData! {
                
                let taskCompleteArray = [i.task1Complete, i.task2Complete, i.task3Complete]
                
                if i.task1Complete == true && i.task2Complete == true && i.task3Complete == true {
                    historyTableView.tableSectionName.append("\(i.date) \(i.goal) - Complete")
                    goalCompleteCount += 1
                } else {
                    historyTableView.tableSectionName.append("\(i.date) \(i.goal) - Not Complete")
                }
                historyTableView.tableCellData.append([i.task1, i.task2, i.task3])
                historyTableView.taskCompletetion.append(taskCompleteArray)
                
                for i in taskCompleteArray {
                    if i == true {
                        trueCount += 1
                    }
                }
            }
        }
        //reverse arrays to show end of month on top
        historyTableView.tableSectionName.reverse()
        historyTableView.tableCellData.reverse()
        historyTableView.taskCompletetion.reverse()
        if historyTableView.tableSectionName.isEmpty {
            monthSummaryLabel.text = "There is currently no data held for this month."
        } else {
            monthSummaryLabel.text = "For \(historyViewModel.monthArray[index]). \n You have completed \(goalCompleteCount) out of \(historyTableView.tableSectionName.count) Goals with \(trueCount) out of \(historyTableView.taskCompletetion.count * 3) tasks being completed."
        }
    }
    
    func assignDependencies(historyViewModel: HistoryViewModel, historyFlow: HistoryFlow) {
        self.historyFlow = historyFlow
        self.historyViewModel = historyViewModel
    }
}

