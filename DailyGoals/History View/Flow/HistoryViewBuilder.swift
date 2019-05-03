//
//  HistoryViewBuilder.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 18/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewBuilder {
    
    static func create() -> UIViewController {
        
        
        let navigator = UINavigationController()
        let historyViewModel = HistoryViewModel()
        let historyFlow = HistoryFlow(navigator: navigator)
        let historyControl = UIStoryboard(name: "HistoryView", bundle: nil).instantiateInitialViewController() as! HistoryViewController
        historyControl.assignDependencies(historyViewModel: historyViewModel, historyFlow: historyFlow)

        navigator.setViewControllers([historyControl], animated: true)
        return navigator
    }
}
