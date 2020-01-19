//
//  File.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Database

class ProfileCoordinator: Coordinator {
    private let database: AppDatabase
    private let userHelper: UserHelper
    
    weak var parentViewController: UIViewController?
    
    private let navController = UINavigationController()
    var rootViewController: UIViewController {
        return navController
    }
    
    private lazy var profileViewModel: ProfileViewModel = {
        return ProfileViewModel(database: self.database, userHelper: self.userHelper, coordinator: self)
    }()

    init(database: AppDatabase, userHelper: UserHelper) {
        self.database = database
        self.userHelper = userHelper
    }
    
    func start() {
        let viewController = ProfileViewController(viewModel: self.profileViewModel)
        
        navController.navigationBar.isTranslucent = true
        navController.setViewControllers([viewController], animated: false)
    }
}
