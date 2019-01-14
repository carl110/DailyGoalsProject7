//
//  ViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class DailyTaskViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var checkBox: CheckBox!
    
    @IBAction func checkBox(_ sender: Any) {
        if checkBox.isChecked == false {
            textField.text = "Checked" }
        else {
            textField.text = "UnChecked"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    
}

