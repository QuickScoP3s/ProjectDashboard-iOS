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
	
	private let refreshControl = UIRefreshControl()
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
		
		let addButton = UIBarButtonItem(title: "Add", style: .plain, target: viewModel, action: #selector(viewModel.addTask))
		parent?.navigationItem.setRightBarButton(addButton, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
		
		taskList.delegate = viewModel
		taskList.dataSource = viewModel
		taskList.refreshControl = refreshControl
		taskList.register(SubtitleCell.self, forCellReuseIdentifier: "TaskCell")
		
		taskListSelector.addTarget(self, action: #selector(reloadData), for: .valueChanged)
		reloadData()
	}
	
	@objc func refresh(_ refreshControl: UIRefreshControl) {
		let completedTasks = taskListSelector.selectedSegmentIndex == 1
		
		viewModel.fetchTasks { result in
			switch result {
				case .failure(let error):
					print("😓 \(error.localizedDescription)")
				case .success:
					DispatchQueue.main.async {
						self.viewModel.showTasks(completed: completedTasks)
						self.taskList.reloadData()
					}
			}
			
			refreshControl.endRefreshing()
		}
	}
	
	@objc func reloadData() {
		refreshControl.beginRefreshing()
		refresh(self.refreshControl)
	}
}
