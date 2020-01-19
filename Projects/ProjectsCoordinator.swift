//
//  ProjectsCoordinator.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Database

class ProjectsCoordinator: Coordinator {
    private let networking: Networking
    private let database: AppDatabase
    private let userHelper: UserHelper
    
    weak var parentViewController: UIViewController?
    
    private var navController = UINavigationController()
    var rootViewController: UIViewController {
        return navController
    }
    
    private lazy var projectViewModel: ProjectsViewModel = {
        return ProjectsViewModel(networking: self.networking,
                                 database: self.database,
                                 userHelper: self.userHelper,
                                 coordinator: self)
    }()

    init(networking: Networking, database: AppDatabase, userHelper: UserHelper) {
        self.networking = networking
        self.database = database
        self.userHelper = userHelper
    }
    
    func start() {
        let viewController = ProjectsViewController(viewModel: self.projectViewModel)
        navController.setViewControllers([viewController], animated: false) // Hack to set root controller on existing navcontroller
    }
    
    func presentDetails(projectId: Int) {
        let viewModel = ProjectDetailsViewModel(projectId: projectId,
                                                networking: self.networking,
                                                database: self.database,
                                                coordinator: self)
        
        let viewController = ProjectDetailsViewController(viewModel: viewModel)
        navController.pushViewController(viewController, animated: true)
    }
}
