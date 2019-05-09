//
//  DailyTaskModel.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 01/05/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

public enum AlertBox: String, CaseIterable {
    
    case usePreviouseGoal
    case enterNewGoalAndTasks
    case completeData
    case completeInputs
    
    public static func getKey(from value: String) -> AlertBox? {
        return AlertBox.allCases.first(where: { $0.rawValue == value })
    }
    
    func name() -> String {
        return self.rawValue.titlecased()
    }
    
}
