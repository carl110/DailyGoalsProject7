//
//  DailyGoalData.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 29/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class DailyGoalData {
    
    var text: String = ""
    var isSelected: Bool = false
    
    init(text: String) {
        self.text = text
    }
    
    func toggle() {
        self.isSelected = !self.isSelected
    }
}
