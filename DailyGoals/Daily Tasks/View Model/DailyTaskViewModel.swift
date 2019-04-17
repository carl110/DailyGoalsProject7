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
    
    var taskState: Bool? = nil
    let todaysDate = Date().string(format: "dd MMM yyyy")
}
