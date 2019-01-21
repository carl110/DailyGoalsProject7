//
//  DailyTaskBuilder.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 18/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class DailyTaskBuilder {
    
    static func create() -> UIViewController {
    
    
        let navigator = UINavigationController()
        let dailyTaskViewModel = DailyTaskViewModel()
        let dailyTaskFlow = DailyTaskFlow(navigator: navigator)
        let dailyTaskControl = UIStoryboard(name: "DailyTask", bundle: nil).instantiateInitialViewController() as! DailyTaskViewController
        dailyTaskControl.assignDependencies(dailyTaskFlow: dailyTaskFlow, dailyTaskViewModel: dailyTaskViewModel)
        
        navigator.setViewControllers([dailyTaskControl], animated: true)
        return navigator
        
        
    }
}
