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
    
    @IBOutlet weak var labelTitle: UITextField!
    @IBOutlet weak var headerBachground: UIView!
    @IBOutlet weak var checkBox: CheckBox!
    
    var delegate: HeaderSectionDelegate?
    
    func toggle() {
        checkBox.isChecked = !checkBox.isChecked
    }
    
    func config(goal: DailyGoalData) {
        labelTitle.text = "\(goal.text)"
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.isEnabled = false
//        labelTitle.numberOfLines = 0
        headerBachground.backgroundColor = UIColor.Blues.lightBlue
    }

    @IBAction func cliclAction(_ sender: Any) {
        checkBox.isChecked = !checkBox.isChecked
        delegate?.headerSectionCell(self)
    }
}



