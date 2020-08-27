//
//  ProjectDetailsCoordinator.swift
//  Projects
//
//  Created by Waut Wyffels on 10/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

class ProjectDetailsCoordinator: Coordinator {
	
	private let projectId: Int
	private let projectName: String
	
	private let networking: Networking
	private let userHelper: UserHelper
	
	weak var parentViewController: UIViewController?
	
	private var tabBarController = ProjectTabBarController()
	var rootViewController: UIViewController {
		return tabBarController
	}
	
	private lazy var taskViewModel: TaskListViewModel = {
		return TaskListViewModel(projectId: self.projectId,
										 networking: self.networking,
										 coordinator: self)
	}()
	
	private lazy var detailsViewModel: ProjectDetailsViewModel = {
		return ProjectDetailsViewModel(projectId: self.projectId,
												 networking: self.networking)
	}()
	
	init(projectId: Int, projectName: String, networking: Networking, userHelper: UserHelper) {
		self.projectId = projectId
		self.projectName = projectName
		self.networking = networking
		self.userHelper = userHelper
	}
	
	func start() {
		let taskList = TaskListViewController(viewModel: self.taskViewModel)
		taskList.tabBarItem = UITabBarItem(title: "Tasks",
													  image: UIImage(systemName: "list.bullet"),
													  selectedImage: nil)
		
		let projectProperties = ProjectDetailsViewController(viewModel: self.detailsViewModel)
		projectProperties.tabBarItem = UITabBarItem(title: "Details",
																  image: UIImage(systemName: "doc.text.magnifyingglass"),
																  selectedImage: nil)
		
		let controllers: [UIViewController] = [
			taskList,
			projectProperties
		]
		
		tabBarController.navigationItem.title = self.projectName
		tabBarController.hidesBottomBarWhenPushed = true
		tabBarController.modalPresentationStyle = .fullScreen
		tabBarController.tabBar.tintColor = .systemIndigo
		tabBarController.viewControllers = controllers
	}
	
	func presentAddTask() {
		let viewModel = TaskDetailsViewModel(projectId: self.projectId,
														 networking: self.networking,
														 coordinator: self)
		
		let viewController = TaskDetailsViewController(viewModel: viewModel)
		tabBarController.present(viewController, animated: true)
	}
	
	func presentTaskDetails(withId id: Int) {
		let viewModel = TaskDetailsViewModel(projectId: self.projectId,
														 taskId: id,
														 networking: self.networking,
														 coordinator: self)
		
		let viewController = TaskDetailsViewController(viewModel: viewModel)
		tabBarController.present(viewController, animated: true)
	}
	
	func presentPersonPicker(projectId: Int) {
		let viewModel = PersonPickerViewModel(projectId: projectId,
														  networking: self.networking)
		
		if let delegate = tabBarController.presentedViewController as? PersonPickerDelegate {
			viewModel.delegate = delegate
		}
		
		let viewController = PersonPickerViewController(viewModel: viewModel)
		tabBarController.presentedViewController?.present(viewController, animated: true)
	}
	
	func refreshTasksOverview() {
		guard let taskView = self.tabBarController.selectedViewController as? TaskListViewController else {
			return
		}
		
		taskView.reloadData()
	}
}
