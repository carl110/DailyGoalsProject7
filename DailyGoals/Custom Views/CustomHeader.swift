//
//  CustomHeader.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 28/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    
    func config(goal: DailyGoal) {
        labelTitle.text = "\(goal.text)"
        checkBox.isChecked = goal.isSelected
        labelTitle.numberOfLines = 2
    }

}



