//
//  DailyTaskViewController+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 28/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension DailyTaskViewController: UITableViewDataSource, UITableViewDelegate, CheckBoxDelegate {
    

    
    func checkBoxDidClick(owner: CheckBox.CheckBoxOwner, state: Bool) {
        print("checkBox: \(owner.rawValue) \(state)")
        
        let rowCount = dailyTaskTableView.indexPathsForRowsInSection(0)
        

        
        if owner == .Goal && state == false {
            for i in rowCount {
                cellsData[i.row].isSelected = true
//                dailyTaskTableView.reloadRows(at: [i as IndexPath], with: .fade)
            }
        } else if owner == .Goal && state == true {
            for i in rowCount {
                cellsData[i.row].isSelected = false
//                dailyTaskTableView.reloadRows(at: [i as IndexPath], with: .fade)
            }
        }

        


    }
    
    
    //Number of section required for table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionExpanded == true ? cellsData.count : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
        
        headerView.checkBox.checkBoxDelegate = self
        headerView.checkBox.owner = .Goal
        headerView.config(goal: sectionData[section])
        headerView.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(DailyTaskViewController.sectionHeaderWasTouched(_:)))
        headerView.addGestureRecognizer(headerTapGesture)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.config(task: cellsData[indexPath.row])
        cell.checkBox.checkBoxDelegate = self
        cell.checkBox.owner = .Task
        return cell
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellsData[indexPath.row].toggle()
        dailyTaskTableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
//        sectionExpanded = !sectionExpanded
        sectionData[0].toggle()
        dailyTaskTableView.reloadData()
    }
}


