//
//  TabBarFlowController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 18/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TabBarFlow: NSObject {
    
    fileprivate let tbController: UITabBarController
    
    init(tbController: UITabBarController) {
        self.tbController = tbController
    }
    
    func getDailyTaskController() -> UIViewController {
        return DailyTaskBuilder.create()
    }
    
    func getHistoryViewController() -> UIViewController {
        return HistoryViewBuilder.create()
    }

    func getProgressViewController() -> UIViewController {
        return ProgressViewBuilder.create()
    }
}
