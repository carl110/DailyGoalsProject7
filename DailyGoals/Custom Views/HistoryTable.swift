//
//  HistoryTable.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 27/03/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class HistoryTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var dailyTaskViewModel = DailyTaskViewModel()
    
    override func awakeFromNib() {
        delegate = self
        dataSource = self
        
        //Stop selection of rows
        self.allowsSelection = false
        
        //hide unused rows
        self.tableFooterView = UIView()
        
        //call custom header
        let headerNib = UINib.init(nibName: "CustomHeaderHistory", bundle: Bundle.main)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: "CustomHeaderHistory")

    }
    
    var taskCompletetion: Array<Any> = []
    var tableCellData: Array<Any> = []
    var tableSectionName: Array<Any> = []
    
    var sectionTouched: Int?
    
    var expandedSectionHeaderNumber: Int = -1
    
    let HeaderSectionTag: Int = 1
    
    //Number of section required for table
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return tableSectionName.count
    }
    
    //Number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = self.tableCellData[section] as! NSArray
            return arrayOfItems.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderHistory") as! CustomHeaderHistory
        
        headerView.labelTitle.text = self.tableSectionName[section] as? String
        headerView.config()
        
        headerView.imageView.image = UIImage(named: "chevron")
        headerView.imageView.tag = HeaderSectionTag + section
        
        headerView.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(self.sectionHeaderWasTouched(_:)))
        headerView.addGestureRecognizer(headerTapGesture)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as UITableViewCell
        let section = self.tableCellData[indexPath.section] as! NSArray
        let completeTask = self.taskCompletetion[indexPath.section] as! NSArray
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = section[indexPath.row] as? String
        cell.backgroundColor = UIColor.Greens.standardGreen
        if completeTask[indexPath.row] as! Bool == false {
            cell.backgroundColor = UIColor.Reds.standardRed
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Colapsing open sections
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! CustomHeaderHistory
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(HeaderSectionTag + section) as? UIImageView
        sectionTouched = section
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
            self.scrollToBottomRow()
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.viewWithTag(HeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    //Hide open cells when table is scrolled
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        
        if self.expandedSectionHeaderNumber != -1 {
                    guard let image = self.viewWithTag(HeaderSectionTag + sectionTouched!) as? UIImageView else { return print ("No image") }
            
            tableViewCollapeSection(sectionTouched!, imageView: image)
        }

    }
    
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.tableCellData[section] as! NSArray
        
        self.expandedSectionHeaderNumber = -1
        if (sectionData.count == 0) {
            return
        } else {
            //turn chevron around
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
        }
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.tableCellData[section] as! NSArray
        
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1
            return
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.insertRows(at: indexesPath, with: UITableView.RowAnimation.none)
        }
    }
    
    func reloadTableView(_ tableView: UITableView) {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
    
}

