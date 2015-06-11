//
//  BeastedViewController.swift
//  beastlistblackbelt
//
//  Created by Jeff on 5/14/15.
//  Copyright (c) 2015 Jeff. All rights reserved.
//

import Foundation
import UIKit
class BeastedViewController: UITableViewController {
    var tasks = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Task.getAllBeasted()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tasks = Task.getAllBeasted()
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dequeued: AnyObject = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath)
        let cell = dequeued as! UITableViewCell
        cell.textLabel!.text = tasks[indexPath.row].objective
        let df = NSDateFormatter()
        df.dateFormat = "EEE MMMM d"
        cell.detailTextLabel!.text = df.stringFromDate(tasks[indexPath.row].completedAt!)
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tasks[indexPath.row].delete()
        tasks = Task.getAllBeasted()
        tableView.reloadData()
    }
}
