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
    
    private var trueCount = 0
    private var goalCompleteCount = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var historyTableView: HistoryTable!
    @IBOutlet weak var monthPickerView: MonthPickerView!
    @IBOutlet weak var monthPickerButton: UIButton!
    @IBOutlet weak var monthSummaryLabel: UILabel!
    
    func assignDependencies(historyViewModel: HistoryViewModel, historyFlow: HistoryFlow) {
        self.historyFlow = historyFlow
        self.historyViewModel = historyViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelSetUp()
        allSavedData()
        monthPickerViewSetUp()
        monthPickerButtonSetUp()
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
        monthPickerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func monthPickerViewSetUp() {
        monthPickerView.backgroundColor = UIColor.Greens.seaGreen
        monthPickerView.roundCorners(for: [.topLeft, .bottomLeft], cornerRadius: 8)
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
        
        if historyTableView.tableSectionName.count > 0 {
            historyTableView.tableSectionName.removeLast()
            historyTableView.tableCellData.removeLast()
            historyTableView.taskCompletetion.removeLast()
        }
    }
    
    func dataByMonth() {
        
        trueCount = 0
        goalCompleteCount = 0
        let index = monthPickerView.selectedRow(inComponent: 0)
        let yearIndex = monthPickerView.selectedRow(inComponent: 1)
        
        //set array for month number
        let dateArray = Array(1...12)
        
        //Array uses extension to get number of days in month for that year
        for day in 1...self.getTotalDates(year: Int(historyViewModel.yearArray[yearIndex])!, month: dateArray[index]) {
            
            //Format to ensure 2 digit number
            let date = "\(String(format: "%02d", day)) \(String(format: "%02d", dateArray[index])) \(historyViewModel.yearArray[yearIndex])"
            //fecth data for each day in the selected month
            let fetchedData = CoreDataManager.shared.fetchGoalDataForDate(date: date)
            //for each entry on CoreData append to correct array
            for data in fetchedData! {
                
                let taskCompleteArray = [data.task1Complete, data.task2Complete, data.task3Complete]
                
                if data.task1Complete == true && data.task2Complete == true && data.task3Complete == true {
                    historyTableView.tableSectionName.append("\(data.date) \(data.goal) - Complete")
                    goalCompleteCount += 1
                } else {
                    historyTableView.tableSectionName.append("\(data.date) \(data.goal) - Not Complete")
                }
                historyTableView.tableCellData.append([data.task1, data.task2, data.task3])
                historyTableView.taskCompletetion.append(taskCompleteArray)
                
                for taskComplete in taskCompleteArray {
                    if taskComplete == true {
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
    
    @IBAction func monthPickerButton(_ sender: Any) {
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
}

