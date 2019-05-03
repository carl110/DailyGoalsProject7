//
//  DailyTaskModel.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 01/05/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

public enum AlertBox: String {

    case usePreviouseGoal
    case enterNewGoalAndTasks
    case completeData

    func name() -> String {
        return self.rawValue.titlecased()
    }
}
