//
//  DailyTaskViewController+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 28/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension DailyTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Number of section required for table
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //Number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionExpanded == true ? cellsData.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "custom header"
//    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
        
        headerView.config(goal: sectionData[section])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.colorWithHexString(hexStr: "#160C76")
//        header.textLabel?.textColor = UIColor.white
        header.textLabel?.numberOfLines = 2
//        header.textLabel?.lineBreakMode = .byWordWrapping
        
//        let headerFrame = self.view.frame.size
//        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18))
//        theImageView.image = UIImage(named: "chevron")
//        header.addSubview(theImageView)
        
        // add gesture to header to tap and open
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(DailyTaskViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.config(task: cellsData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellsData[indexPath.row].toggle()
        dailyTaskTableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        sectionExpanded = !sectionExpanded
        dailyTaskTableView.reloadData()
    }
}


