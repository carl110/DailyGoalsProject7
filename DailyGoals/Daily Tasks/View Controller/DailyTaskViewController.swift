//
//  ViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class DailyTaskViewController: UIViewController {
    
    @IBOutlet var tickedCheckBox: CheckBox!
    @IBOutlet var emptyCheckBox: CheckBox!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tickedCheckBox.delegate = self as? CheckBoxDelegate
        self.emptyCheckBox.delegate = self as? CheckBoxDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }

    func checkBoxDidChange(checkBox: CheckBox) {
        if checkBox == self.tickedCheckBox {
            self.emptyCheckBox.isChecked = !checkBox.isChecked
        } else {
            self.tickedCheckBox.isChecked = !checkBox.isChecked
        }
    }

    
}

