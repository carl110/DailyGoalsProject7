//
//  DailyTaskData.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 16/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class CellData {
    
    var text: String = ""
    var state: Bool = false

    init(text: String, state: Bool) {
        self.text = text
        self.state = state
    }
}

