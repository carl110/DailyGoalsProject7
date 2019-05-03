//
//  ProgressModel.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 01/05/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation

class ProgressModel {
    
    var chartType: AAChartType?
    var step: Bool?
    var aaChartModel: AAChartModel?
    var aaChartView: AAChartView?
    
    var chartLabel: [String] = []
    var monthRange: ClosedRange = 0...0
    var goalTrueData: [Int] = []
    var goalAllData: [Int] = []
    var task1TrueData: [Int] = []
    var task2TrueData: [Int] = []
    var task3TrueData: [Int] = []
    
    func resetArrays() {
        chartLabel.removeAll()
        goalAllData.removeAll()
        task1TrueData.removeAll()
        task2TrueData.removeAll()
        task3TrueData.removeAll()
        goalTrueData.removeAll()
    }
}
