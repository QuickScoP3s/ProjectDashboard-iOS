//
//  TaskListViewController.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 10/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Components

class TaskListViewController: UIViewController {
    private let viewModel: TaskListViewModel
    
    @IBOutlet weak var taskListSelector: UISegmentedControl!
    @IBOutlet weak var taskList: UITableView!
    
    // MARK: Init
    
    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "TaskListView", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Load View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTask))
        parent?.navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskList.delegate = viewModel
        taskList.dataSource = viewModel
        taskList.register(SubtitleCell.self, forCellReuseIdentifier: "TaskCell")
        
        taskListSelector.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        reloadData()
    }
    
    @objc func addTask() {
        
    }
    
    @objc func reloadData() {
        let completedTasks = taskListSelector.selectedSegmentIndex == 1
        
        view.activityIndicator.startAnimating()
        viewModel.fetchTasks(completedTasks: completedTasks) { result in
            self.view.activityIndicator.stopAnimating()
        }
    }
}
