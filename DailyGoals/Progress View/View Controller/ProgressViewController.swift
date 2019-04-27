//
//  ProgressViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    private var progressViewModel: ProgressViewModel!
    private var progressFlow: ProgressFlow!
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickDateFrom: UIPickerView!
    @IBOutlet weak var pickDateTo: UIPickerView!
    @IBOutlet weak var selectDatRange: UIButton!
    
    var chartType: AAChartType?
    var step: Bool?
    var aaChartModel: AAChartModel?
    var aaChartView: AAChartView?
    var chartLabel: [String] = []
    
    let date = Date()
    var thisMonth = Int()
    var goalTrueData: [Int] = []
    var goalAllData: [Int] = []
    var task1TrueData: [Int] = []
    var task2TrueData: [Int] = []
    var task3TrueData: [Int] = []
    
    
    @IBAction func selectDateRange(_ sender: UIButton) {
        
        //if first date is after second date it is invalid
        if (pickDateFrom.selectedRow(inComponent: 1) > pickDateTo.selectedRow(inComponent: 1)) || (pickDateFrom.selectedRow(inComponent: 1) == pickDateTo.selectedRow(inComponent: 1) && pickDateFrom.selectedRow(inComponent: 0) > pickDateTo.selectedRow(inComponent: 0)) {
            alertBoxWithAction(title: "Invalid Selection", message: "You cannot choose a start date prior to the end date", options: "Reselect Dates") { (option) in
                switch(option) {
                case 0:
                    break
                default:
                    break
                }
            }
        } else {
            aaChartView!.customAnimtation()
          
            goalAllData.removeAll()
            task1TrueData.removeAll()
            task2TrueData.removeAll()
            task3TrueData.removeAll()
            goalTrueData.removeAll()
            chartLabel.removeAll()
            var monthRange: ClosedRange = 0...0

            
            for year in pickDateFrom.selectedRow(inComponent: 1)...pickDateTo.selectedRow(inComponent: 1) {

                if pickDateFrom.selectedRow(inComponent: 1) - pickDateTo.selectedRow(inComponent: 1) == 0 {
                    monthRange = pickDateFrom.selectedRow(inComponent: 0)...pickDateTo.selectedRow(inComponent: 0)
                } else if pickDateFrom.selectedRow(inComponent: 1) == year {
                    monthRange = pickDateFrom.selectedRow(inComponent: 1)...11
                } else if pickDateTo.selectedRow(inComponent: 1) == year {
                    monthRange = 0...pickDateTo.selectedRow(inComponent: 1)
                } else {
                    monthRange = 0...11
                }
                
                
                
                for month in monthRange {
                    var goalAllCount = 0
                    var goalCount = 0
                    var count1 = 0
                    var count2 = 0
                    var count3 = 0
                    for day in 1...31 {
                        
                        //format date to 2 digit number
                        let date = "\(String(format: "%02d", day)) \(String(format: "%02d", month + 1)) \(progressViewModel.yearArray[year])"

                        //fecth data for each day in the selected month
                        let fetchedData = CoreDataManager.shared.fetchGoalDataForToday(date: date)
                        //for each entry on CoreData append to correct array
                        for i in fetchedData! {
                            goalAllCount += 1
                            if i.task1Complete == true {
                                count1 += 1
                            }
                            if i.task2Complete == true {
                                count2 += 1
                            }
                            if i.task3Complete == true {
                                count3 += 1
                            }
                            if i.task1Complete && i.task2Complete && i.task3Complete == true {
                                goalCount += 1
                            }
                        }
                    }
                    goalAllData.append(goalAllCount)
                    task1TrueData.append(count1)
                    task2TrueData.append(count2)
                    task3TrueData.append(count3)
                    goalTrueData.append(goalCount)
                    chartLabel.append("\(progressViewModel.monthArray[month].prefix(3)) \(progressViewModel.yearArray[year].suffix(2))")
                }
            }
        }
                setUpAAChartView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabelSetUp()
        
        DispatchQueue.main.async {
            self.monthPickerViewSetUp()
            self.buttonSetUp()
        }
        
        thisMonth = Int(date.month)!
        setupTaskData()
        chartType = .bar
        setUpAAChartView()

    }
    
    func titleLabelSetUp() {
        titleLabel.titleLabelFormat(colour: UIColor.Purples.standardPurple)
        titleLabel.text = "Progress"
    }
    
    func buttonSetUp() {
        selectDatRange.roundCorners(for: [.topLeft, .topRight], cornerRadius: 8)
        selectDatRange.backgroundColor = UIColor.Purples.standardPurple
        selectDatRange.setTitle("Select the date range bellow and press this button", for: .normal)
        selectDatRange.setTitleColor(UIColor.Shades.standardWhite, for: .normal)
        selectDatRange.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        selectDatRange.titleLabel?.lineBreakMode = .byWordWrapping
        selectDatRange.titleLabel?.textColor = UIColor.Shades.standardWhite
        selectDatRange.centerTextHorizontally(spacing: 8)
    }
    
    func monthPickerViewSetUp() {
        pickDateFrom.backgroundColor = UIColor.Purples.standardPurple

        
        pickDateTo.backgroundColor = UIColor.Purples.standardPurple
        self.pickDateTo.roundCorners(for: [.bottomLeft, .bottomRight], cornerRadius: 8)
    }
    
    func assignDependencies(progressViewModel: ProgressViewModel, progressFlow: ProgressFlow) {
        self.progressFlow = progressFlow
        self.progressViewModel = progressViewModel
    }
}

extension ProgressViewController {
    
    
    //Get numbers for true counts
    func setupTaskData () {
        
        for year in progressViewModel.yearArray {
        for month in 1...12 {
            var goalAllCount = 0
            var goalCount = 0
            var count1 = 0
            var count2 = 0
            var count3 = 0
            for day in 1...31 {
                

                //Format to ensure 2 digit number
                let date = "\(String(format: "%02d", day)) \(String(format: "%02d", month)) \(year)"
                
                //fecth data for each day in the selected month
                let fetchedData = CoreDataManager.shared.fetchGoalDataForToday(date: date)
                //for each entry on CoreData append to correct array
                for i in fetchedData! {
                    goalAllCount += 1
                    if i.task1Complete == true {
                        count1 += 1
                    }
                    if i.task2Complete == true {
                        count2 += 1
                    }
                    if i.task3Complete == true {
                        count3 += 1
                    }
                    if i.task1Complete && i.task2Complete && i.task3Complete == true {
                        goalCount += 1
                    }
                }
            }
            goalAllData.append(goalAllCount)
            task1TrueData.append(count1)
            task2TrueData.append(count2)
            task3TrueData.append(count3)
            goalTrueData.append(goalCount)
        }
        }
    }
    
    func setUpAAChartView() {
        aaChartView = AAChartView()
        let chartViewWidth = view.frame.size.width
        let chartViewHeight = view.frame.size.height - 300
        aaChartView?.frame = CGRect(x: 0,
                                    y: 125,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        ///AAChartViewd
//        aaChartView?.contentHeight = chartViewHeight
        aaChartView!.translatesAutoresizingMaskIntoConstraints = true
//        aaChartView!.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        aaChartView!.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        view.addSubview(aaChartView!)
        aaChartView!.fadeIn()
        aaChartView?.scrollEnabled = false
        aaChartView?.isClearBackgroundColor = true
        aaChartModel = AAChartModel()
            .chartType(chartType!)
            .colorsTheme(["#1e90ff","#ef476f","#ffd066","#04d69f","#25547c",])
            .axisColor("#ffffff")
            .title("")//图形标题
 
            .dataLabelEnabled(false)//是否显示数字
            .tooltipValueSuffix(" completed")//浮动提示框单位后缀
            .animationType(.bounce)//图形渲染动画类型为"bounce"
            .backgroundColor("#1d4991")//若要使图表背景色为透明色,可将 backgroundColor 设置为 "rgba(0,0,0,0)" 或 "rgba(0,0,0,0)". 同时确保 aaChartView?.isClearBackgroundColor = true
            .series([
                AASeriesElement()
                    .name("Out of")
                    .data(goalAllData)
                    .toDic()!,
                AASeriesElement()
                    .name("Goal")
                    .data(goalTrueData)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 1")
                    .data(task1TrueData)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 2")
                    .data(task2TrueData)
                    .toDic()!,
                AASeriesElement()
                    .name("Task 3")
                    .data(task3TrueData)
                    .toDic()!,
                ])
        
        configureTheStyleForDifferentTypeChart()
        
        aaChartView?.aa_drawChartWithChartModel(aaChartModel!)
    }
    
    func configureTheStyleForDifferentTypeChart() {

        if (chartType == .bar) {
            aaChartModel?
                .categories(chartLabel)
                .legendEnabled(true)
                .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
                .animationType(.bounce)
                .animationDuration(1200)
        } else if (chartType == .area && step == true)
            || (chartType == .line && step == true) {
            aaChartModel?.series([
                AASeriesElement()
                    .name("Goal")
                    .data(goalTrueData)
                    .step(true)//设置折线样式为直方折线,连接点位置默认靠左👈
                    
                    .toDic()!,
                AASeriesElement()
                    .name("Task 1")
                    .data(task1TrueData)
                    .step(true)//设置折线样式为直方折线,连接点位置默认靠左👈
                    .toDic()!,
                AASeriesElement()
                    .name("Task 2")
                    .data(task2TrueData)
                    .step(true)//设置折线样式为直方折线,连接点位置默认靠左👈
                    .toDic()!,
                AASeriesElement()
                    .name("Task 3")
                    .data(task3TrueData)
                    .step(true)//设置折线样式为直方折线,连接点位置默认靠左👈
                    .toDic()!,
                ])
        }
    }  
}
