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
    
    func config(task: CellData) {
        label.text = "\(task.text)"
//               label.text = "\(task.text) :: \(task.isSelected)"
        checkBox.isChecked = task.isSelected
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        cellBackground.backgroundColor = UIColor.colorWithHexString(hexStr: "#6FBDCD")

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
        label.text = ""
//        checkBox.isChecked = false
    }

}
