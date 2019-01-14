//
//  CheckBox.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "tickedcheckbox")! as UIImage
    let uncheckedImage = UIImage(named: "emptycheckbox")! as UIImage
    
    // Bool property chooses images for the variables
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    //change image to the opposite image when selected
    @objc func buttonClicked(sender: UIButton) {
        if(sender == self) {
            if isChecked == true {
                isChecked = false  }
            else {
                isChecked = true
            }
        }
    }
}

