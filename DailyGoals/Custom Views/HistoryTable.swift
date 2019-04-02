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
    }

    var tableCellData: Array<Any> = [ ["Task 1", "Task 2","Task 3"],
                                      ["Task 1", "Task 2","Task 3"],
                                      ["Task 1", "Task 2","Task 3"] ]
    var tableSectionName: Array<Any> = ["Day 1", "Day2", "Day 3"]
    
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
    
    //Name used in the section headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.tableSectionName.count != 0) {
            return self.tableSectionName[section] as? String
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.Blues.lightBlue
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.numberOfLines = 0
        header.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        //close open section when another is opened
        if let viewWithTag = self.viewWithTag(HeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18))
        theImageView.image = UIImage(named: "chevron")
        theImageView.tag = HeaderSectionTag + section
        header.addSubview(theImageView)
        
        // add gesture to header to tap and open
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(self.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as UITableViewCell
        let section = self.tableCellData[indexPath.section] as! NSArray
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = section[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Colapsing open sections
        @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(HeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
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
            self.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
        }
    }
    //Reload data when table is scrolled to ensure no missing sections
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.reloadData()
    }

}

