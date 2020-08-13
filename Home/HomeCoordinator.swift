//
//  HomeCoordinator.swift
//  Home
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Projects
import Teams
import Profile

class HomeCoordinator: Coordinator {
	private let networking: Networking
	private let userHelper: UserHelper
	
	private var features: [Feature]?
	
	weak var parentViewController: UIViewController?
	weak var delegate: CoordinatorDelegate?
	
	private var tabBarController = HomeTabBarController()
	var rootViewController: UIViewController {
		return tabBarController
	}
	
	private lazy var projects: Feature = {
		return Projects(networking: self.networking, userHelper: self.userHelper)
	}()
	
	private lazy var teams: Feature = {
		return Teams(networking: self.networking, userHelper: self.userHelper)
	}()
	
	private lazy var profile: Feature = {
		let profileFeature = Profile(userHelper: self.userHelper)
		profileFeature.signOutCallback = self.close
		
		return profileFeature
	}()
	
	init(networking: Networking, userHelper: UserHelper) {
		self.networking = networking
		self.userHelper = userHelper
	}
	
	func start() {
		features = [projects, teams, profile]
		
		// Define tabBarItems here, otherwise they won't be loaded
		let projectsController = projects.coordinator.rootViewController
		projectsController.tabBarItem = UITabBarItem(title: "Projects",
																	image: UIImage(systemName: "bookmark"),
																	selectedImage: UIImage(systemName: "bookmark.fill"))
		
		let teamsController = teams.coordinator.rootViewController
		teamsController.tabBarItem = UITabBarItem(title: "Teams",
																image: UIImage(systemName: "person.3"),
																selectedImage: UIImage(systemName: "person.3.fill"))
		
		let profileController = profile.coordinator.rootViewController
		profileController.tabBarItem = UITabBarItem(title: "Profile",
																  image: UIImage(systemName: "person.circle"),
																  selectedImage: UIImage(systemName: "person.circle.fill"))
		
		let controllers: [UIViewController] = [
			projectsController,
			teamsController,
			profileController
		]
		
		tabBarController.tabDelegate = self
		tabBarController.modalPresentationStyle = .fullScreen
		tabBarController.tabBar.tintColor = .systemIndigo
		tabBarController.viewControllers = controllers
		
		parentViewController?.present(tabBarController, animated: false)
	}
}

// MARK: - TabBarDelegate

extension HomeCoordinator: TabBarDelegate {
	func tabChanged(selectedIndex: Int) {
		DispatchQueue.main.async {
			self.features?[selectedIndex].start(on: self.tabBarController)
		}
	}
}

// MARK: - ViewControllerDelegate

extension HomeCoordinator: ViewControllerDelegate {
	func close() {
		parentViewController?.presentedViewController?.dismiss(animated: false, completion: nil)
		delegate?.didFinish(coordintor: self)
	}
}
