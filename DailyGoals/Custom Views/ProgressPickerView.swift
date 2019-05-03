//
//  ProgressPickerView.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 27/04/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class ProgressPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    fileprivate var progressViewModel = ProgressViewModel()
    
    override func awakeFromNib() {
        dataSource = self
        delegate = self
        //Get index of current year and month
        let month = Int(Date().month)!
        let year = progressViewModel.yearArray.firstIndex(of: Date().year)!
        //set picker to show current month when opened
        self.selectRow(year, inComponent: 1, animated: true)
        self.selectRow(month - 1, inComponent: 0, animated: true)
    }
    
    //number of columns for pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //number of rows for pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {        if component == 0 {
        return progressViewModel.monthArray.count
    } else {
        return progressViewModel.yearArray.count
        }
    }
    //data for pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return progressViewModel.monthArray[row]
        } else {
            return progressViewModel.yearArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            let attributedString = NSAttributedString(string: progressViewModel.monthArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.Shades.standardWhite])
            return attributedString
        } else {
            let attributedString = NSAttributedString(string: progressViewModel.yearArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.Shades.standardWhite])
            return attributedString
        }
    }
}
