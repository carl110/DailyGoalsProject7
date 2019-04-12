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
        return 1
    }
    //number of rows for pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return historyViewModel.monthArray.count
    }
    //data for pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return historyViewModel.monthArray[row]
    }
    
    
    
}
