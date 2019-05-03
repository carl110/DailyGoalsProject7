//
//  ProgressViewController+extension.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 27/04/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

extension ProgressViewController {
    //Get numbers for true counts
    func setupTaskData () {
        
        progressModel.resetArrays()
        
        let monthTo = pickDateTo.selectedRow(inComponent: 0)
        let monthFrom = pickDateFrom.selectedRow(inComponent: 0)
        let yearFrom = pickDateFrom.selectedRow(inComponent: 1)
        let yearTo = pickDateTo.selectedRow(inComponent: 1)
               
        //Run through years
        for year in yearFrom...yearTo {
            //ensure all months are looped if more that 1 year selected
            if yearFrom - yearTo == 0 {
                progressModel.monthRange = monthFrom...monthTo
            } else if yearFrom == year {
                progressModel.monthRange = monthFrom...11
            } else if yearTo == year {
                progressModel.monthRange = 0...monthTo
            } else {
                progressModel.monthRange = 0...11
            }

            //Run through month
            for month in progressModel.monthRange {
                var goalAllCount = 0
                var goalCount = 0
                var count1 = 0
                var count2 = 0
                var count3 = 0
                for day in 1...self.getTotalDates(year: Int(progressViewModel.yearArray[year])!, month: month + 1) {
                    
                    //format date to 2 digit number
                    let date = "\(String(format: "%02d", day)) \(String(format: "%02d", month + 1)) \(progressViewModel.yearArray[year])"

                    //fecth data for each day in the selected month
                    let fetchedData = CoreDataManager.shared.fetchGoalDataForDate(date: date)
                    //for each entry on CoreData append to correct array
                    for data in fetchedData! {
                        goalAllCount += 1
                        if data.task1Complete == true {
                            count1 += 1
                        }
                        if data.task2Complete == true {
                            count2 += 1
                        }
                        if data.task3Complete == true {
                            count3 += 1
                        }
                        if data.task1Complete && data.task2Complete && data.task3Complete == true {
                            goalCount += 1
                        }
                    }
                }
                progressModel.goalAllData.append(goalAllCount)
                progressModel.task1TrueData.append(count1)
                progressModel.task2TrueData.append(count2)
                progressModel.task3TrueData.append(count3)
                progressModel.goalTrueData.append(goalCount)
                progressModel.chartLabel.append("\(progressViewModel.monthArray[month].prefix(3)) \(progressViewModel.yearArray[year].suffix(2))")
            }
        }
    }
    
    func setUpAAChartView() {

        progressModel.aaChartView = AAChartView()
        let chartViewWidth = view.frame.size.width
        let chartViewHeight = view.frame.size.height - (titleLabel.frame.height + selectDatRange.frame.height + pickDateTo.frame.height + pickDateFrom.frame.height + 50)
        progressModel.aaChartView?.frame = CGRect(x: 0,
                                    y: titleLabel.frame.maxY,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        ///AAChartViewd
        progressModel.aaChartView!.translatesAutoresizingMaskIntoConstraints = true
        progressModel.aaChartView!.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        view.addSubview(progressModel.aaChartView!)
        progressModel.aaChartView?.scrollEnabled = false
        progressModel.aaChartView?.isClearBackgroundColor = true
        progressModel.aaChartModel = AAChartModel()
            .chartType(progressModel.chartType!)
            .colorsTheme(["#1e90ff","#ef476f","#ffd066","#04d69f","#25547c",])
            .axisColor("#ffffff")
            .title("")
            
            .dataLabelEnabled(false)
            .tooltipValueSuffix(" completed")
            .animationType(.bounce)
            .backgroundColor("#1d4991")
            .series([
                AASeriesElement()
                    .name("Out of")
                    .data(progressModel.goalAllData)
                    .toDic()!,
                AASeriesElement()
                    .name("Goal")
                    .data(progressModel.goalTrueData)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 1")
                    .data(progressModel.task1TrueData)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 2")
                    .data(progressModel.task2TrueData)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 3")
                    .data(progressModel.task3TrueData)
                    .toDic()!,
                ])
        
        configureTheStyleForDifferentTypeChart()
        
        progressModel.aaChartView?.aa_drawChartWithChartModel(progressModel.aaChartModel!)
    }
    
    func configureTheStyleForDifferentTypeChart() {
        
        if (progressModel.chartType == .bar) {
            progressModel.aaChartModel?
                .categories(progressModel.chartLabel)
                .legendEnabled(true)
                .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
                .animationType(.bounce)
                .animationDuration(1200)
        } else if (progressModel.chartType == .area && progressModel.step == true)
            || (progressModel.chartType == .line && progressModel.step == true) {
            progressModel.aaChartModel?.series([
                AASeriesElement()
                    .name("Goal")
                    .data(progressModel.goalTrueData)
                    .step(true)
                    
                    .toDic()!,
                AASeriesElement()
                    .name("Task 1")
                    .data(progressModel.task1TrueData)
                    .step(true)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 2")
                    .data(progressModel.task2TrueData)
                    .step(true)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 3")
                    .data(progressModel.task3TrueData)
                    .step(true)
                    .toDic()!,
                ])
        }
    }
}
