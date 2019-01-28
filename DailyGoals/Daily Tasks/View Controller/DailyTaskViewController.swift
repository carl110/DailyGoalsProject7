//
//  ViewController.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 14/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit

class DailyTaskViewController: UIViewController {
    
    fileprivate var dailyTaskFlow: DailyTaskFlow!
    fileprivate var dailyTaskViewModel: DailyTaskViewModel!
    fileprivate var dailyTaskData: CellData!
//    //Crate array for table sections and cells
//    var tableCellData: Array<Any> = []
    var tableSectionName: Array<Any> = []
//    //Set intigers for table headers
//    var expandedSectionHeaderNumber: Int = -1
//    let HeaderSectionTag: Int = 10
    
    var cellsData: [CellData] = [CellData(text: "a"),
                                 CellData(text: "b"),
                                 CellData(text: "c"),
                                 CellData(text: "d"),
                                 CellData(text: "e"),
                                 CellData(text: "f"),
                                 CellData(text: "g"),
                                 CellData(text: "h"),
                                 CellData(text: "i"),
                                 CellData(text: "j"),
                                 CellData(text: "k"),
                                 CellData(text: "l"),
                                 CellData(text: "m"),
                                 CellData(text: "n"),
                                 CellData(text: "o"),
                                 CellData(text: "p"),
                                 CellData(text: "r"),
                                 CellData(text: "s"),
                                 CellData(text: "t"),
                                 CellData(text: "u")]
    
    @IBOutlet weak var dailyTaskTableView: UITableView!
    
    var sectionExpanded = true
    
//    @IBAction func checkBox(_ sender: Any) {
//        if checkBox.isChecked == false {
//            dailyGoal.text = "Checked" }
//        else {
//            dailyGoal.text = "UnChecked"
//        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //delegate and datasource for table
        dailyTaskTableView.delegate = self
        dailyTaskTableView.dataSource = self
        dailyTaskTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        
        
//        //Create Alert box for Goals input
//        showInputDialog(title: "Todays Goal",
//                        subtitle: "Please enter your goal for today",
//                        actionTitle: "Add New Goal",
//                        cancelTitle: "Use the previous goal",
//                        inputPlaceholder: "Enter your new goal here...")
//        { (goalInput:String?) in
//            self.tableSectionName.append("Todays Goal - \(Date().string(format: "dd MMM yyyy")) \n \(goalInput ?? "New")")
//
//            self.showInputTasks(title: "Task 1",
//                                 subtitle: "Please enter task 1 to complete your goal",
//                                 actionTitle: "Add New Task",
//                                 inputPlaceholder: "Enter your new task here...")
//            { (task1Input:String?) in
//
//                self.showInputTasks(title: "Task 2",
//                                     subtitle: "Please enter task 2 to complete your goal",
//                                     actionTitle: "Add New Task",
//                                     inputPlaceholder: "Enter your new task here...")
//                { (task2Input:String?) in
//
//                    self.showInputTasks(title: "Task 3",
//                                         subtitle: "Please enter task 3 to complete your goal",
//                                         actionTitle: "Add New Task",
//                                         inputPlaceholder: "Enter your new task here...")
//                    { (task3Input:String?) in
////                        DailyTaskData(text: "b")
//                        self.cellsData.append(DailyTaskData(text: "\(task1Input ?? "")"))
////                        self.dailyTaskData.config.append(task1Input ?? "no task")
////                        self.tableCellData.append([task1Input ?? "", task2Input ?? "", task3Input ?? ""])
//                    }
//                }
//            }
//            self.dailyTaskTableView.reloadData()
//        }
        
    }
    //func for TabBarController
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
        self.dailyTaskViewModel = dailyTaskViewModel
    }

}

//    //Name used in the section headers
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (self.tableSectionName.count != 0) {
//            return self.tableSectionName[section] as? String
//        }
//        return ""
//    }
//
//    //Height of section title boxes
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        //recast view as a UITableViewHeaderFooterView
//        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.contentView.backgroundColor = UIColor.colorWithHexString(hexStr: "#160C76")
//        header.textLabel?.textColor = UIColor.white
//        header.textLabel?.numberOfLines = 2
//        header.textLabel?.lineBreakMode = .byWordWrapping
//        //close open section when another is opened
//        if let viewWithTag = self.view.viewWithTag(HeaderSectionTag + section) {
//            viewWithTag.removeFromSuperview()
//        }
//        let headerFrame = self.view.frame.size
//        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18))
//        theImageView.image = UIImage(named: "chevron")
//        theImageView.tag = HeaderSectionTag + section
//        header.addSubview(theImageView)
//
//        // add gesture to header to tap and open
//        header.tag = section
//        let headerTapGesture = UITapGestureRecognizer()
//        headerTapGesture.addTarget(self, action: #selector(DailyTaskViewController.sectionHeaderWasTouched(_:)))
//        header.addGestureRecognizer(headerTapGesture)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TableViewCell
//        let section = self.dailyTaskData.taskTitle[indexPath.section] as! NSArray
//        cell.textLabel?.textColor = UIColor.black
//        cell.textLabel?.text = section[indexPath.row] as? String
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    //Colapsing open sections
//    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
//        let headerView = sender.view as! UITableViewHeaderFooterView
//        let section    = headerView.tag
//        let eImageView = headerView.viewWithTag(HeaderSectionTag + section) as? UIImageView
//
//        if (self.expandedSectionHeaderNumber == -1) {
//            self.expandedSectionHeaderNumber = section
//            tableViewExpandSection(section, imageView: eImageView!)
//        } else {
//            if (self.expandedSectionHeaderNumber == section) {
//                tableViewCollapeSection(section, imageView: eImageView!)
//            } else {
//                let cImageView = self.view.viewWithTag(HeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
//                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
//                tableViewExpandSection(section, imageView: eImageView!)
//            }
//        }
//    }
//
//    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
//        let sectionData = self.dailyTaskData.taskTitle[section] as! NSArray
//
//        self.expandedSectionHeaderNumber = -1
//        if (sectionData.count == 0) {
//            return
//        } else {
//            //turn chevron around
//            UIView.animate(withDuration: 0.4, animations: {
//                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
//            })
//            var indexesPath = [IndexPath]()
//            for i in 0 ..< sectionData.count {
//                let index = IndexPath(row: i, section: section)
//                indexesPath.append(index)
//            }
//            self.dailyTaskTableView!.beginUpdates()
//            self.dailyTaskTableView!.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
//            self.dailyTaskTableView!.endUpdates()
//        }
//    }
//
//    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
//        let sectionData = self.dailyTaskData.taskTitle[section] as! NSArray
//
//        if (sectionData.count == 0) {
//            self.expandedSectionHeaderNumber = -1
//            return
//        } else {
//            UIView.animate(withDuration: 0.4, animations: {
//                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
//            })
//            var indexesPath = [IndexPath]()
//            for i in 0 ..< sectionData.count {
//                let index = IndexPath(row: i, section: section)
//                indexesPath.append(index)
//            }
//            self.expandedSectionHeaderNumber = section
//            self.dailyTaskTableView!.beginUpdates()
//            self.dailyTaskTableView!.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
//            self.dailyTaskTableView!.endUpdates()
//        }
//    }


