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
    
    
    
    var tableCellData: Array<Any> = []
    var tableSectionName: Array<Any> = []
    
    var tasks: [DailyTaskData] = []
    
    var expandedSectionHeaderNumber: Int = -1
    let HeaderSectionTag: Int = 1
    
    @IBOutlet weak var dailyTaskTableView: UITableView!
    
//    @IBAction func checkBox(_ sender: Any) {
//        if checkBox.isChecked == false {
//            dailyGoal.text = "Checked" }
//        else {
//            dailyGoal.text = "UnChecked"
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCellData = [["Task 1", "Task 2", "Task 3"], ["Task 1", "Task 2", "Task 3"], ["Task 1", "Task 2", "Task 3"]]
        tableSectionName = ["Goal 1", "Goal 2", "Goal 3"]

        dailyTaskTableView.delegate = self
        dailyTaskTableView.dataSource = self
        
        self.dailyTaskTableView!.tableFooterView = UIView()
        
//        tasks = createTasks()
        
        showInputDialog(title: "Todays Goal",
                        subtitle: "Please enter your goal for today",
                        actionTitle: "Add New Goal",
                        cancelTitle: "Use the previous goal",
                        inputPlaceholder: "Enter your new goal here...")
        { (input:String?) in
            print("Todays \(input ?? "")")
        }

    }
    
    func createGoal() -> [DailyGoal] {
        
        var tempGoal: [DailyGoal] = []
        
        let goal = DailyGoal(goalTitle: "Goal")
        
        tempGoal.append(goal)
        return [goal]
    }
    
    func createTasks() -> [[DailyTaskData]] {

        var tempTasks: [DailyTaskData] = []

        let task1 = DailyTaskData(taskTitle: "Task 1")
        let task2 = DailyTaskData(taskTitle: "Task 2")
        let task3 = DailyTaskData(taskTitle: "Task 3")

        tempTasks.append(task1)
        tempTasks.append(task2)
        tempTasks.append(task3)

        return [tempTasks]
    }
    
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
        self.dailyTaskViewModel = dailyTaskViewModel
    }
    
    
}

extension DailyTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    //Height of section title boxes
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.colorWithHexString(hexStr: "#160C76")
        header.textLabel?.textColor = UIColor.white
        //close open section when another is opened
        if let viewWithTag = self.view.viewWithTag(HeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18))
        theImageView.image = UIImage(named: "chevron")
        theImageView.tag = HeaderSectionTag + section
        header.addSubview(theImageView)
        
        // add gesture to header to tap and open
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(DailyTaskViewController.sectionHeaderWasTouched(_:)))
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
                let cImageView = self.view.viewWithTag(HeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
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
            self.dailyTaskTableView!.beginUpdates()
            self.dailyTaskTableView!.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.dailyTaskTableView!.endUpdates()
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
            self.dailyTaskTableView!.beginUpdates()
            self.dailyTaskTableView!.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.dailyTaskTableView!.endUpdates()
        }
    }

}

