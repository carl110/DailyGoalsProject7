//
//  TableViewCell.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 16/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
 
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var checkBox: CheckBox!
    
    @IBOutlet weak var label: UILabel!
    
    var isToggled: Bool = false
    var isPreviouseState: Bool = false
    
    func toggle() {
        checkBox.isChecked = !checkBox.isChecked
        isToggled = checkBox.isChecked
    }
    
    func config(task: CellData, checkBoxState: Bool?) {
        label.text = "\(task.text)"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        cellBackground.backgroundColor = UIColor.Blues.softBlue
        
        if let _checkboxState = checkBoxState {
            checkBox.isChecked = _checkboxState
        }
    }
    
    override func prepareForReuse() {
        label.text = ""
    }

}
