//
//  ProgressViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    var progressViewModel: ProgressViewModel!
    private var progressFlow: ProgressFlow!
    var progressModel = ProgressModel()

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickDateFrom: UIPickerView!
    @IBOutlet weak var pickDateTo: UIPickerView!
    @IBOutlet weak var selectDatRange: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setUpAAChartView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dispatch used to ensure all corners rounded before view loads
        DispatchQueue.main.async { [weak self] in
            self!.monthPickerViewSetUp()
            self!.buttonSetUp()
        }
        titleLabelSetUp()
        setupTaskData()
        progressModel.chartType = .bar
    }
    
    func titleLabelSetUp() {
        titleLabel.titleLabelFormat(colour: UIColor.Purples.standardPurple)
        titleLabel.text = "Progress"
    }
    
    func buttonSetUp() {
        selectDatRange.roundCorners(for: [.topLeft, .topRight], cornerRadius: 8)
        selectDatRange.backgroundColor = UIColor.Purples.standardPurple
        selectDatRange.setTitle("Select \n From - To", for: .normal)
        selectDatRange.setTitleColor(UIColor.Shades.standardWhite, for: .normal)
        selectDatRange.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        selectDatRange.titleLabel?.lineBreakMode = .byWordWrapping
        selectDatRange.titleLabel?.textColor = UIColor.Shades.standardWhite
        selectDatRange.centerTextHorizontally(spacing: 8)
    }
    
    func monthPickerViewSetUp() {
        pickDateFrom.backgroundColor = UIColor.Purples.standardPurple
        pickDateTo.backgroundColor = UIColor.Purples.standardPurple
        pickDateTo.roundCorners(for: [.bottomLeft, .bottomRight], cornerRadius: 8)
    }
    
    @IBAction func selectDateRange(_ sender: UIButton) {
        
        //if first date is after second date it will reverse
        if (pickDateFrom.selectedRow(inComponent: 1) > pickDateTo.selectedRow(inComponent: 1)) || (pickDateFrom.selectedRow(inComponent: 1) == pickDateTo.selectedRow(inComponent: 1) && pickDateFrom.selectedRow(inComponent: 0) > pickDateTo.selectedRow(inComponent: 0)) {
            
            let component0 = pickDateTo.selectedRow(inComponent: 0)
            let component1 = pickDateTo.selectedRow(inComponent: 1)
            pickDateTo.selectRow((pickDateFrom.selectedRow(inComponent: 0)), inComponent: 0, animated: true)
            pickDateTo.selectRow((pickDateFrom.selectedRow(inComponent: 1)), inComponent: 1, animated: true)
            pickDateFrom.selectRow(component0, inComponent: 0, animated: false)
            pickDateFrom.selectRow(component1, inComponent: 1, animated: false)
            
        }
            setupTaskData()
            setUpAAChartView()
        
    }
    
    func assignDependencies(progressViewModel: ProgressViewModel, progressFlow: ProgressFlow) {
        self.progressFlow = progressFlow
        self.progressViewModel = progressViewModel
    }
}
