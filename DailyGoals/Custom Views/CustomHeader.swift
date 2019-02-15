//
//  CustomHeader.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 28/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderSectionDelegate {
    func headerSectionCell(_ cell: CustomHeader)
}

class CustomHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var headerBachground: UIView!
    @IBOutlet weak var checkBox: CheckBox!
    
    var delegate: HeaderSectionDelegate?
    
    func toggle() {
        checkBox.isChecked = !checkBox.isChecked
    }
    
    func config(goal: DailyGoalData) {
        labelTitle.text = "\(goal.text) :: \(goal.isSelected)"
        labelTitle.numberOfLines = 0
        headerBachground.backgroundColor = UIColor.colorWithHexString(hexStr: "#6FA0CD")
    }
    
    @IBAction func cliclAction(_ sender: Any) {
        checkBox.isChecked = !checkBox.isChecked
        delegate?.headerSectionCell(self)
    }

}



