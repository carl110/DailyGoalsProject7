//
//  HistoryViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private var historyViewModel: HistoryViewModel!
    private var historyFlow: HistoryFlow!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelSetUp()
    }
    
    func titleLabelSetUp() {
        titleLabel.titleLabelFormat(colour: UIColor.Greens.standardGreen)
        titleLabel.text = "History"
    }
    
    func assignDependencies(historyViewModel: HistoryViewModel, historyFlow: HistoryFlow) {
        self.historyFlow = historyFlow
        self.historyViewModel = historyViewModel
        
        
    }
}
