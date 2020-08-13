//
//  ProjectsCoordinator.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import ProjectDetails

class ProjectsCoordinator: Coordinator {
	private let networking: Networking
	private let userHelper: UserHelper
	
	weak var parentViewController: UIViewController?
	
	private var navController = UINavigationController()
	var rootViewController: UIViewController {
		return navController
	}
	
	// Store the presentedProject as a strong variable
	// Otherwise Swift ARC (Mem. Mgmt) will remove it (and children) from memory
	private var presentedProject: ProjectDetails?
	
	private lazy var projectViewModel: ProjectsViewModel = {
		return ProjectsViewModel(networking: self.networking,
										 coordinator: self)
	}()
	
	init(networking: Networking, userHelper: UserHelper) {
		self.networking = networking
		self.userHelper = userHelper
	}
	
	func start() {
		let viewController = ProjectsViewController(viewModel: self.projectViewModel)
		navController.viewControllers = [viewController] // Set viewcontroller as first and only controller in the stack
	}
	
	func presentAddProject() {
		let viewModel = ProjectCreatorViewModel(networking: self.networking,
															 coordinator: self)
		
		let viewController = ProjectCreatorViewController(viewModel: viewModel)
		navController.present(viewController, animated: true)
	}
	
	func presentProjectDetails(withId id: Int, projectName name: String) {
		presentedProject = ProjectDetails(projectId: id, projectName: name, networking: self.networking, userHelper: self.userHelper)
		presentedProject!.start(on: navController)
		
		navController.pushViewController(presentedProject!.coordinator.rootViewController, animated: true)
	}
	
	func refreshProjectsOverview() {
		guard let projectView = self.navController.viewControllers[0] as? ProjectsViewController else {
			return
		}
		
		projectView.reloadProjects()
	}
}
