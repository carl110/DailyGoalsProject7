//
//  UIViewController+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 24/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    //Alertbox with text fields
    func showGoalTaskDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         goalPlaceHolder:String? = nil,
                         task1PlaceHolder:String? = nil,
                         task2PlaceHolder:String? = nil,
                         task3PlaceHolder:String? = nil,
                         actionHandler: ((_ goal: String?, _ task1:String?, _ task2:String?, _ task3:String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (goalText:UITextField) in
            goalText.placeholder = goalPlaceHolder
        }
        alert.addTextField { (task1Text: UITextField) in
            task1Text.placeholder = task1PlaceHolder
        }
        alert.addTextField { (task2Text: UITextField) in
            task2Text.placeholder = task2PlaceHolder
        }
        alert.addTextField { (task3Text: UITextField) in
            task3Text.placeholder = task3PlaceHolder
        }
        
        let actionButton = UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let goalField =  alert.textFields?[0] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            guard let task1Field = alert.textFields?[1] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            guard let task2Field = alert.textFields?[2] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            guard let task3Field = alert.textFields?[3] else {
                actionHandler?(nil, nil, nil, nil)
                return
            }
            actionHandler?(goalField.text, task1Field.text, task2Field.text, task3Field.text)
        })
        alert.addAction(actionButton)
        self.present(alert, animated: true, completion: nil)
    }
}
