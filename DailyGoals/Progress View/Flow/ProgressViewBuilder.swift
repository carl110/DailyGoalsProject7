//
//  ProgressViewBuilder.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 18/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class ProgressViewBuilder {
    
    static func create() -> UIViewController {
        
        
        let navigator = UINavigationController()
        let progressViewModel = ProgressViewModel()
        let progressFlow = ProgressFlow(navigator: navigator)
        let progressControl = UIStoryboard(name: "ProgressView", bundle: nil).instantiateInitialViewController() as! ProgressViewController
        progressControl.assignDependencies(progressViewModel: progressViewModel, progressFlow: progressFlow)
        
        navigator.setViewControllers([progressControl], animated: true)
        return navigator
        
        
    }
}
