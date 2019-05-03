//
//  DailyTaskViewModel.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 18/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class DailyTaskViewModel {
    let todaysDate = Date().string(format: "dd MMM yyyy")
    
    var sectionData: [DailyGoalData] = []
    var cellsData: [CellData] = []
    var runPreviouseTaskAlert = false
    
    var daySubtraction = 1
    
    func checkCoreData() {//if todays data exists then go straight to table
        let checkToday = CoreDataManager.shared.fetchGoalDataForDate(date: todaysDate)
        if (checkToday!.count) > 0 {
            for savedData in checkToday! {
                //Update text in section and rows
                sectionData = [DailyGoalData(text: savedData.goal)]
                cellsData = [CellData(text: savedData.task1, state: savedData.task1Complete), CellData(text: savedData.task2, state: savedData.task2Complete), CellData(text: savedData.task3, state: savedData.task3Complete)]
            }
        } else {
            checkPreviouseGoalStatus()
        }
    }
    
    func checkPreviouseGoalStatus() {
        
        let checkPreviouseGoal = CoreDataManager.shared.fetchGoalDataForDate(date: Date().subtract(days: daySubtraction)!.string(format: "dd MM yyyy"))
        
        //if there is saved data
        if CoreDataManager.shared.fetchGoalData()?.count != 0 {
            //if no data for previouse day go back another day
            while (checkPreviouseGoal?.count)! == 0 {
                daySubtraction += 1
            }
            //If any task is incomplete
            for date in checkPreviouseGoal! {
                if date.task1Complete == false || date.task2Complete == false || date.task3Complete == false {
                    runPreviouseTaskAlert = true
                }
            }
        }
    }
    
    func usePreviouseGoal() {
        let previouseDate = CoreDataManager.shared.fetchGoalDataForDate(date: (Date().subtract(days: daySubtraction)?.string(format: "dd MM yyyy"))!)

        for savedData in previouseDate! {
            //Update text in section and rows
            sectionData = [DailyGoalData(text: savedData.goal)]
            let taskArray = [savedData.task1, savedData.task2, savedData.task3]
            let taskCompleteArray = [savedData.task1Complete, savedData.task2Complete, savedData.task3Complete]
            for index in 0 ..< taskArray.count {
                cellsData.append(CellData(text: taskArray[index], state: taskCompleteArray[index]))
            }
        }
    }
}
