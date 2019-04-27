//
//  MonthPickerView.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 12/04/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class MonthPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    fileprivate var historyViewModel = HistoryViewModel()
    
    override func awakeFromNib() {
        dataSource = self
        delegate = self
        
        self.selectRow(12, inComponent: 0, animated: true)
    }
    
    //number of columns for pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //number of rows for pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {        if component == 0 {
            return historyViewModel.monthArray.count
        } else {
            return historyViewModel.yearArray.count
        }
    }
    //data for pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return historyViewModel.monthArray[row]
        } else {
            return historyViewModel.yearArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            let attributedString = NSAttributedString(string: historyViewModel.monthArray[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.Shades.standardWhite])
            return attributedString
        } else {
            let attributedString = NSAttributedString(string: historyViewModel.yearArray[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.Shades.standardWhite])
            return attributedString
        }
        
    }
    
    
}
