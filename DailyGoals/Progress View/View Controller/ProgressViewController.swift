//
//  ProgressViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    private var progressViewModel: ProgressViewModel!
    private var progressFlow: ProgressFlow!
    
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
        titleLabel.titleLabelFormat(colour: UIColor.Purples.standardPurple)
        titleLabel.text = "Progress"
    }
    
    func assignDependencies(progressViewModel: ProgressViewModel, progressFlow: ProgressFlow) {
        self.progressFlow = progressFlow
        self.progressViewModel = progressViewModel
        
        
    }
}
