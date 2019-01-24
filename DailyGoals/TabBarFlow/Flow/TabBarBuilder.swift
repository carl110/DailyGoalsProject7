//
//  TabBarFlowBuilder.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 18/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TabBarBuilder {
    
    struct TabIndex {
        static let DailyTasks = 0
        static let HistoryView = 1
        static let ProgressView = 2
    }
    
    static func showIn(window: UIWindow) {
        
        let tbController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TabBarController
        let tbFlow = TabBarFlow(tbController: tbController)
        
        tbController.viewControllers = setupTabControllers(tbFlow: tbFlow)
        tbController.assignDependencies(tbFlow: tbFlow)
        
        window.rootViewController = tbController
    }
    
    private static func setupTabControllers(tbFlow: TabBarFlow) -> [UIViewController] {
        
        let dailyTasksVC = tbFlow.getDailyTaskController()
        dailyTasksVC.tabBarItem = UITabBarItem(title: "Daily Task", image: UIImage(named: "dailyTask"), tag: 0)
        
        let historyVC = tbFlow.getHistoryViewController()
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history"), tag: 1)
        
        let progressVC = tbFlow.getProgressViewController()
        progressVC.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(named: "progress"), tag: 2)
        
        let viewControllerList = [dailyTasksVC, historyVC, progressVC]
        
        return viewControllerList
    }
}
