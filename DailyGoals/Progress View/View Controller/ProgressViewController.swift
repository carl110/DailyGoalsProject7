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
    
    var chartType: AAChartType?
    var step: Bool?
    var aaChartModel: AAChartModel?
    var aaChartView: AAChartView?
    
    let date = Date()
    var thisMonth = Int()
    var goalTrueData: [Int] = []
    var goalAllData: [Int] = []
    var task1TrueData: [Int] = []
    var task2TrueData: [Int] = []
    var task3TrueData: [Int] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var barGraph: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelSetUp()
        
        thisMonth = Int(date.month)!
        setupTaskData()
        chartType = .bar
        
        DispatchQueue.main.async {
            self.setUpTheSwiths()
            self.setUpTheSegmentControls()
            self.setUpAAChartView()
        }

    }
    
    func titleLabelSetUp() {
        titleLabel.titleLabelFormat(colour: UIColor.Purples.standardPurple)
        titleLabel.text = "Progress"
    }
    
    func assignDependencies(progressViewModel: ProgressViewModel, progressFlow: ProgressFlow) {
        self.progressFlow = progressFlow
        self.progressViewModel = progressViewModel
        
        
    }
    

    
}

extension ProgressViewController {
    
    
    //Get numbers for true counts
    func setupTaskData () {
        
        for month in 1...thisMonth {
            var goalAllCount = 0
            var goalCount = 0
            var count1 = 0
            var count2 = 0
            var count3 = 0
            
            for day in 1...31 {
                //Format to ensure 2 digit number
                let date = "\(String(format: "%02d", day)) \(String(format: "%02d", month)) 2019"
                
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
    
    func setUpAAChartView() {
        aaChartView = AAChartView()
        let chartViewWidth = view.frame.size.width - (view.frame.size.width / 7)
        let chartViewHeight = view.frame.size.height - (view.frame.size.height / 2)
        aaChartView?.frame = CGRect(x: barGraph.frame.minX,
                                    y: barGraph.frame.minY,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        ///AAChartViewd
        aaChartView?.contentHeight = chartViewHeight - (chartViewHeight / 12.5)
        view.addSubview(aaChartView!)
        aaChartView?.scrollEnabled = false
        aaChartView?.isClearBackgroundColor = true
        
        aaChartModel = AAChartModel()
            .chartType(chartType!)
            .colorsTheme(["#1e90ff","#ef476f","#ffd066","#04d69f","#25547c",])
            .axisColor("#ffffff")
            .title("Completed Goals and Tasks")//图形标题
            .titleColor("#ffffff")
            .subtitle("By Month")//图形副标题
            .subtitleColor("#ffffff")
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
                .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
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
    
    func setUpTheSegmentControls() {
        let segmentedNamesArr:[[String]]
        let typeLabelNamesArr:[String]
        
        if chartType == .column
            || chartType == .bar {
            segmentedNamesArr = [
                ["No stacking",
                 "Normal stacking"],
//                ["Square corners",
//                 "Rounded corners",
//                 "Wedge"]
            ]
            typeLabelNamesArr = [
                "Stacking Type Selection",
                "Corners Style Type Selection"
            ]
        } else {
            segmentedNamesArr = [
                ["No stacking",
                 "Normal stacking",
                 "Percent stacking"],
                ["Circle",
                 "Square",
                 "Diamond",
                 "Triangle",
                 "Triangle-down"]
            ]
            typeLabelNamesArr = [
                "Stacking Type Selection",
                "Chart Symbol Type Selection"
            ]
        }
        
        
        for i in 0..<segmentedNamesArr.count {
            let segment = UISegmentedControl.init(items: segmentedNamesArr[i] as [Any])
            segment.frame = CGRect(x: barGraph.frame.minX,
                                   y: barGraph.frame.minY * CGFloat(i) + (view.frame.size.height - (view.frame.size.height / 3.5)),
                                   width: view.frame.size.width - (view.frame.size.width / 4),
                                   height: view.frame.size.height / 25)
            segment.tag = i
            segment.tintColor = .red
            segment.selectedSegmentIndex = 0
            segment.addTarget(self,
                              action: #selector(segmentDidSelected(segmentedControl:)),
                              for:.valueChanged)
            view.addSubview(segment)
            
            let subLabel = UILabel()
            subLabel.font = UIFont(name: "EuphemiaUCAS", size: 12.0)
            subLabel.frame = CGRect(x: barGraph.frame.minX,
                                    y: barGraph.frame.minY * CGFloat(i) + (view.frame.size.height - (view.frame.size.height / 3)),
                                    width: view.frame.size.width - (view.frame.size.width / 4),
                                    height: view.frame.size.height / 25)
            subLabel.text = typeLabelNamesArr[i] as String
            subLabel.backgroundColor = .clear
            subLabel.textColor = .lightGray
            view.addSubview(subLabel)
        }
        
    }
    
    @objc func segmentDidSelected(segmentedControl:UISegmentedControl) {
        switch segmentedControl.tag {
        case 0:
            let stackingArr = [
                AAChartStackingType.none,
                .normal,
                .percent
            ]
            aaChartModel?.stacking(stackingArr[segmentedControl.selectedSegmentIndex])
            
        case 1:
            if chartType == .column || chartType == .bar {
                let borderRadiusArr = [0,10,100]
                aaChartModel?.borderRadius(borderRadiusArr[segmentedControl.selectedSegmentIndex])
            } else {
                let symbolArr = [
                    AAChartSymbolType.circle,
                    .square,
                    .diamond,
                    .triangle,
                    .triangleDown
                ]
                aaChartModel?.symbol(symbolArr[segmentedControl.selectedSegmentIndex])
            }
            
        default: break
        }
        aaChartView?.aa_refreshChartWholeContentWithChartModel(aaChartModel!)
    }
    
    func setUpTheSwiths() {
        let nameArr: [String]
        let switchWidth: CGFloat
        
        if chartType == .column || chartType == .bar {
            nameArr = [
                "xReversed",
                "yReversed",
                "xInverted",
                "Polarization",
                "DataShow"
            ]
            switchWidth = (view.frame.size.width - (view.frame.size.width / 8)) / 5
        } else {
            nameArr = [
                "xReversed",
                "yReversed",
                "xInverted",
                "Polarization",
                "DataShow",
                "HideMarker"
            ]
            switchWidth = (view.frame.size.width - (view.frame.size.width / 8)) / 6
        }
        
        for i in 0..<nameArr.count {
            let uiswitch = UISwitch()
            uiswitch.frame = CGRect(x: switchWidth * CGFloat(i) + (switchWidth / 16),
                                    y: view.frame.size.height - (view.frame.size.height / 7),
                                    width: switchWidth,
                                    height: view.frame.size.height / 25)
            uiswitch.isOn = false
            uiswitch.tag = i
            //            uiswitch.onTintColor = UIColor.blue
            uiswitch.addTarget(self,
                               action: #selector(switchDidChange(switchView:)),
                               for: .valueChanged)
            view.addSubview(uiswitch)
            
            let subLabel = UILabel()
            subLabel.font = UIFont(name: "EuphemiaUCAS", size: nameArr.count == 5 ? 10.0 : 9.0)
            subLabel.frame = CGRect(x: switchWidth * CGFloat(i) + (switchWidth / 16),
                                    y: view.frame.size.height - (view.frame.size.height / 11),
                                    width: switchWidth,
                                    height: view.frame.size.height / 14.5)
            subLabel.text = nameArr[i] as String
            subLabel.backgroundColor = .clear
            subLabel.textColor = .lightGray
            view.addSubview(subLabel)
        }
    }
    
    @objc func switchDidChange(switchView:UISwitch) {
        switch switchView.tag {
        case 0:
            aaChartModel?.xAxisReversed(switchView.isOn)
        case 1:
            aaChartModel?.yAxisReversed(switchView.isOn)
        case 2:
            aaChartModel?.inverted(switchView.isOn)
        case 3:
            aaChartModel?.polar(switchView.isOn)
        case 4:
            aaChartModel?.dataLabelEnabled(switchView.isOn)
        case 5:
            aaChartModel?.markerRadius(switchView.isOn ? 0 : 5)//折线连接点半径长度,为0时相当于没有折线连接点
        default:
            break
        }
        
        aaChartView?.aa_refreshChartWholeContentWithChartModel(aaChartModel!)
    }
    
    func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
    
}
