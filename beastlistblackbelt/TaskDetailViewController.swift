//
//  TaskDetailViewController.swift
//  beastlistblackbelt
//
//  Created by Jeff on 5/14/15.
//  Copyright (c) 2015 Jeff. All rights reserved.
//

import Foundation
import UIKit
    class TaskDetailViewController: UITableViewController, UITextFieldDelegate {
        @IBOutlet weak var newTaskTextField: UITextField!
        weak var cancelButtonDelegate: CancelButtonDelegate?
        weak var delegate: TaskDetailViewControllerDelegate?
        var taskToEdit: Task?
        override func viewDidLoad() {
            super.viewDidLoad()
            newTaskTextField.delegate = self
            var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            view.addGestureRecognizer(tap)
            if let task = taskToEdit {
                newTaskTextField.text = task.objective
            }
        }
        
        @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
            cancelButtonDelegate?.cancelButtonPressedFrom(self)
        }
        @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
            if let task = taskToEdit {
                task.objective = newTaskTextField.text
                delegate?.taskDetailViewController(self, didFinishEditingTask: task)
            }
            else {
                let task = Task(obj: newTaskTextField.text)
                delegate?.taskDetailViewController(self, didFinishAddingTask: task)
            }
        }
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        func dismissKeyboard() {
            view.endEditing(true)
        }
}