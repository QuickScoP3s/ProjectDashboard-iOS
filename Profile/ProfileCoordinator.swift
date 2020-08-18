//
//  ProfileCoordinator.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

class ProfileCoordinator: Coordinator {
	private let userHelper: UserHelper
	private let networking: Networking
	
	weak var parentViewController: UIViewController?
	weak var delegate: CoordinatorDelegate?
	
	private let navController = UINavigationController()
	var rootViewController: UIViewController {
		return navController
	}
	
	private lazy var profileViewModel: ProfileViewModel = {
		return ProfileViewModel(userHelper: self.userHelper, networking: self.networking, coordinator: self)
	}()
	
	init(userHelper: UserHelper, networking: Networking) {
		self.userHelper = userHelper
		self.networking = networking
	}
	
	func start() {
		let viewController = ProfileViewController(viewModel: self.profileViewModel)
		viewController.delegate = self
		
		navController.navigationBar.isTranslucent = true
		navController.setViewControllers([viewController], animated: false)
	}
}

// MARK: - ViewControllerDelegate

extension ProfileCoordinator: ViewControllerDelegate {
	func close() {
		delegate?.didFinish(coordintor: self)
	}
}
