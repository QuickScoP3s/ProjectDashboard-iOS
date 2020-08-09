//
//  TeamsCoordinator.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

class TeamsCoordinator: Coordinator {
    private let networking: Networking
    private let userHelper: UserHelper
    
    weak var parentViewController: UIViewController?
    
    private let navController = UINavigationController()
    var rootViewController: UIViewController {
        return navController
    }
    
    private lazy var teamViewModel: TeamsViewModel = {
        return TeamsViewModel(networking: self.networking,
                              userHelper: self.userHelper,
                              coordinator: self)
    }()

    init(networking: Networking, userHelper: UserHelper) {
        self.networking = networking
        self.userHelper = userHelper
    }
    
    func start() {
        let viewController = TeamsViewController(viewModel: self.teamViewModel)
        
        navController.navigationBar.isTranslucent = true
        navController.setViewControllers([viewController], animated: false) // Set TeamsViewController as top (and only) controller in the stack
    }
}
