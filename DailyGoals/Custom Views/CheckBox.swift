//
//  CheckBox.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

protocol CheckBoxDelegate {
    func checkBoxDidClick(owner: CheckBox.CheckBoxOwner, state: Bool)
}

extension CheckBoxDelegate {
    func checkBoxDidClick(owner: CheckBox.CheckBoxOwner, state: Bool) {}
}

class CheckBox: UIButton {
    
    enum CheckBoxOwner: String {
        case Goal = "Goal"
        case Task = "Task"
        case none
    }
    // Images
    let checkedImage = UIImage(named: "tickedcheckbox")! as UIImage
    let uncheckedImage = UIImage(named: "emptycheckbox")! as UIImage
    
    var checkBoxDelegate: CheckBoxDelegate? = nil
    var owner: CheckBoxOwner = .none
    
    // Bool property chooses images for the variables
    var isChecked: Bool = false {
        didSet {
            checkBoxDelegate?.checkBoxDidClick(owner: owner, state: isChecked)
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender: )), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    //change image to the opposite image when selected
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false  }
            else {
                isChecked = true
            }
        }
    }
}

