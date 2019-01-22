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
    
    
    
    var tasks: [DailyTaskData] = []

    @IBOutlet weak var dailyGoal: UILabel!
    @IBOutlet weak var dailyTaskTableView: UITableView!
    @IBOutlet weak var checkBox: CheckBox!
    @IBAction func checkBox(_ sender: Any) {
        if checkBox.isChecked == false {
            dailyGoal.text = "Checked" }
        else {
            dailyGoal.text = "UnChecked"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = createTasks()

        dailyTaskTableView.delegate = self
        dailyTaskTableView.dataSource = self
        
        
    }
    
    func createTasks() -> [DailyTaskData] {

        var tempTasks: [DailyTaskData] = []

        let task1 = DailyTaskData(taskTitle: "Task 1")
        let task2 = DailyTaskData(taskTitle: "Task 2")
        let task3 = DailyTaskData(taskTitle: "Task 3")

        tempTasks.append(task1)
        tempTasks.append(task2)
        tempTasks.append(task3)

        return tempTasks
    }
    
    func assignDependencies(dailyTaskFlow: DailyTaskFlow, dailyTaskViewModel: DailyTaskViewModel) {
        self.dailyTaskFlow = dailyTaskFlow
        self.dailyTaskViewModel = dailyTaskViewModel
    }
    
    
}

extension DailyTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TableViewCell

        cell.setTask(task: task)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todays Tasks"
    }

}

