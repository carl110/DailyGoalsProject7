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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.selectedIndex = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        //select initial VC to show
        self.selectedIndex = 1
        //selected item colour
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        //set to false to get solid colour of bar
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.colorWithHexString(hexStr: "#6FA0CD")
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
