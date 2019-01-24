//
//  TableViewCell.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 16/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
 
    @IBOutlet weak var checkBox: CheckBox!
    
    @IBOutlet weak var dailyTasksLabel: UILabel!
    
    func setTask(task: DailyTaskData) {
        dailyTasksLabel.text = task.taskTitle
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
    }

}
