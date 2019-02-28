//
//  TabBarFlow.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 18/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var tbFlow: TabBarFlow!
    
    func assignDependencies(tbFlow: TabBarFlow) {
        self.tbFlow = tbFlow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        //select initial VC to show
        self.selectedIndex = 1
    }
    
    override var navigationItem: UINavigationItem {
        get {
            let item = super.navigationItem
            
            if item.backBarButtonItem == nil {
                item.backBarButtonItem = UIBarButtonItem()
                item.backBarButtonItem!.title = "back"
            }
            
            return item
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
    
}
