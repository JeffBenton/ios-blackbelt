//
//  TaskDetailViewControllerDelegate.swift
//  beastlistblackbelt
//
//  Created by Jeff on 5/14/15.
//  Copyright (c) 2015 Jeff. All rights reserved.
//

import Foundation
protocol TaskDetailViewControllerDelegate: class {
    func taskDetailViewController(controller: TaskDetailViewController, didFinishAddingTask task: Task)
    func taskDetailViewController(controller: TaskDetailViewController, didFinishEditingTask task: Task)
}