//
//  ViewController.swift
//  beastlistblackbelt
//
//  Created by Jeff on 5/14/15.
//  Copyright (c) 2015 Jeff. All rights reserved.
//

import UIKit

class ToBeastViewController: UITableViewController, CancelButtonDelegate, TaskDetailViewControllerDelegate {

    var tasks = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Task.getAllToBeast()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tasks = Task.getAllToBeast()
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dequeued: AnyObject = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath)
        let cell = dequeued as! TaskCell
        cell.taskLabel.text = tasks[indexPath.row].objective
        cell.beastButton.tag = indexPath.row
        return cell
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tasks[indexPath.row].delete()
        tasks = Task.getAllToBeast()
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("EditTask", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewTask" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! TaskDetailViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }
        else if segue.identifier == "EditTask" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! TaskDetailViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.taskToEdit = tasks[indexPath.row]
            }
        }
    }
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func taskDetailViewController(controller: TaskDetailViewController, didFinishAddingTask task: Task) {
        dismissViewControllerAnimated(true, completion: nil)
        task.save()
        tasks = Task.getAllToBeast()
        tableView.reloadData()
    }
    func taskDetailViewController(controller: TaskDetailViewController, didFinishEditingTask task: Task) {
        dismissViewControllerAnimated(true, completion: nil)
        task.save()
        tasks = Task.getAllToBeast()
        tableView.reloadData()
    }
    @IBAction func beastButtonPressed(sender: UIButton) {
        tasks[sender.tag].done = true
        tasks[sender.tag].completedAt = NSDate()
        tasks[sender.tag].save()
        tasks = Task.getAllToBeast()
        tableView.reloadData()
    }
}

