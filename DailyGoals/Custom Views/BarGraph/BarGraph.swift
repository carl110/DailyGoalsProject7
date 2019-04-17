//
//  BarGraph.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 17/04/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class BarGraph: AAChartView {
    
    
    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var chartTitle: UILabel!
    
    override func awakeFromNib() {
        chartType = .bar
        
        //        chartTitle.text = chartType.map { $0.rawValue }
        
        setUpTheSwiths()
        setUpTheSegmentControls()
        
        setUpAAChartView()
    }
    
    
    var chartType: AAChartType?
    var step: Bool?
    var aaChartModel: AAChartModel?
    var aaChartView: AAChartView?
    
    func setUpAAChartView() {
        aaChartView = AAChartView()
        let chartViewWidth = chartView.frame.size.width
        let chartViewHeight = chartView.frame.size.height - 220
        aaChartView?.frame = CGRect(x: 0,
                                    y: 60,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        ///AAChartViewd
        aaChartView?.contentHeight = chartViewHeight - 20
        chartView.addSubview(aaChartView!)
        aaChartView?.scrollEnabled = false
        aaChartView?.isClearBackgroundColor = true
        
        aaChartModel = AAChartModel()
            .chartType(chartType!)
            .colorsTheme(["#1e90ff","#ef476f","#ffd066","#04d69f","#25547c",])
            .axisColor("#ffffff")
            .title("")
            .subtitle("")
            .dataLabelEnabled(false)
            .tooltipValueSuffix("℃")
            .animationType(.bounce)
            .backgroundColor("#22324c")
            .series([
                AASeriesElement()
                    .name("Tokyo")
                    .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                    .toDic()!,
                AASeriesElement()
                    .name("New York")
                    .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                    .toDic()!,
                AASeriesElement()
                    .name("Berlin")
                    .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                    .toDic()!,
                AASeriesElement()
                    .name("London")
                    .data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8])
                    .toDic()!,
                ])
        
        configureTheStyleForDifferentTypeChart()
        
        aaChartView?.aa_drawChartWithChartModel(aaChartModel!)
    }
    
    func configureTheStyleForDifferentTypeChart() {
        aaChartModel?
            .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            .legendEnabled(true)
            .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
            .animationType(.bounce)
            .animationDuration(1200)
    }
    
    func setUpTheSegmentControls() {
        let segmentedNamesArr:[[String]]
        let typeLabelNamesArr:[String]
        
        segmentedNamesArr = [
            ["No stacking",
             "Normal stacking",
             "Percent stacking"],
            ["Square corners",
             "Rounded corners",
             "Wedge"]
        ];
        typeLabelNamesArr = [
            "Stacking Type Selection",
            "Corners Style Type Selection"
        ];
        
        
        for i in 0..<segmentedNamesArr.count {
            let segment = UISegmentedControl.init(items: segmentedNamesArr[i] as [Any])
            segment.frame = CGRect(x: 20,
                                   y: 40.0 * CGFloat(i) + (chartView.frame.size.height - 145),
                                   width: chartView.frame.size.width - 40,
                                   height: 20)
            segment.tag = i;
            segment.tintColor = .red
            segment.selectedSegmentIndex = 0
            segment.addTarget(self,
                              action: #selector(segmentDidSelected(segmentedControl:)),
                              for:.valueChanged)
            chartView.addSubview(segment)
            
            let subLabel = UILabel()
            subLabel.font = UIFont(name: "EuphemiaUCAS", size: 12.0)
            subLabel.frame = CGRect(x: 20,
                                    y: 40 * CGFloat(i) + (chartView.frame.size.height - 165),
                                    width: chartView.frame.size.width - 40,
                                    height: 20)
            subLabel.text = typeLabelNamesArr[i] as String
            subLabel.backgroundColor = .clear
            subLabel.textColor = .lightGray
            chartView.addSubview(subLabel)
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
        
        nameArr = [
            "xReversed",
            "yReversed",
            "xInverted",
            "Polarization",
            "DataShow"
        ]
        switchWidth = (chartView.frame.size.width - 40) / 5
        
        for i in 0..<nameArr.count {
            let uiswitch = UISwitch()
            uiswitch.frame = CGRect(x: switchWidth * CGFloat(i) + 20,
                                    y: chartView.frame.size.height - 70,
                                    width: switchWidth,
                                    height: 20)
            uiswitch.isOn = false
            uiswitch.tag = i;
            //            uiswitch.onTintColor = UIColor.blue
            uiswitch.addTarget(self,
                               action: #selector(switchDidChange(switchView:)),
                               for: .valueChanged)
            chartView.addSubview(uiswitch)
            
            let subLabel = UILabel()
            subLabel.font = UIFont(name: "EuphemiaUCAS", size: nameArr.count == 5 ? 10.0 : 9.0)
            subLabel.frame = CGRect(x: switchWidth * CGFloat(i) + 20,
                                    y: chartView.frame.size.height - 45,
                                    width: switchWidth,
                                    height: 35)
            subLabel.text = nameArr[i] as String
            subLabel.backgroundColor = .clear
            subLabel.textColor = .lightGray
            chartView.addSubview(subLabel)
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
