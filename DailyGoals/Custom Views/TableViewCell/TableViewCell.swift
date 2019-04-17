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
    
   
    @IBOutlet weak var label: UITextField!
    
    var isToggled: Bool = false
    var isPreviouseState: Bool = false
    var task: CellData!
    
    func toggleEdit() {
        label.isEnabled = !label.isEnabled
    }
    
    func toggle() {
        checkBox.isChecked = !checkBox.isChecked
        isToggled = checkBox.isChecked
    }
    
    func config(task: CellData) {
        label.text = "\(task.text)"
        label.backgroundColor = UIColor.clear
        label.isEnabled = false
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
        label.sizeThatFits(CGSize(width: label.frame.size.width, height: label.frame.size.height))
        cellBackground.backgroundColor = UIColor.Blues.softBlue
        
        checkBox.isChecked = task.state
        
        self.task = task
    }
    
    override func prepareForReuse() {
        label.text = ""
    }

}
