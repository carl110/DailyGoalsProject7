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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickDateFrom: UIPickerView!
    @IBOutlet weak var pickDateTo: UIPickerView!
    @IBOutlet weak var selectDatRange: UIButton!
    
    var chartType: AAChartType?
    var step: Bool?
    var aaChartModel: AAChartModel?
    var aaChartView: AAChartView?
    var chartLabel: [String] = []
    var monthRange: ClosedRange = 0...0
    var goalTrueData: [Int] = []
    var goalAllData: [Int] = []
    var task1TrueData: [Int] = []
    var task2TrueData: [Int] = []
    var task3TrueData: [Int] = []
    
    
    @IBAction func selectDateRange(_ sender: UIButton) {
        
        //if first date is after second date it is invalid
        if (pickDateFrom.selectedRow(inComponent: 1) > pickDateTo.selectedRow(inComponent: 1)) || (pickDateFrom.selectedRow(inComponent: 1) == pickDateTo.selectedRow(inComponent: 1) && pickDateFrom.selectedRow(inComponent: 0) > pickDateTo.selectedRow(inComponent: 0)) {
            alertBoxWithAction(title: "Invalid Selection", message: "You cannot choose a start date prior to the end date", options: "Reselect Dates") { (option) in
                switch(option) {
                case 0:
                    break
                default:
                    break
                }
            }
        } else {
            aaChartView!.customAnimtation()
            setupTaskData()
            setUpAAChartView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setUpAAChartView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [weak self] in
            self!.monthPickerViewSetUp()
            self!.buttonSetUp()
        }
        titleLabelSetUp()
        setupTaskData()
        chartType = .bar
    }

    func titleLabelSetUp() {
        titleLabel.titleLabelFormat(colour: UIColor.Purples.standardPurple)
        titleLabel.text = "Progress"
    }
    
    func buttonSetUp() {
        selectDatRange.roundCorners(for: [.topLeft, .topRight], cornerRadius: 8)
        selectDatRange.backgroundColor = UIColor.Purples.standardPurple
        selectDatRange.setTitle("Select the date range bellow and press this button", for: .normal)
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
    
    func assignDependencies(progressViewModel: ProgressViewModel, progressFlow: ProgressFlow) {
        self.progressFlow = progressFlow
        self.progressViewModel = progressViewModel
    }
}
