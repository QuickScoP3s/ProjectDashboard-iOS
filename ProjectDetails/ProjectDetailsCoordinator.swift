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
    
    init(projectId: Int, projectName: String, networking: Networking, userHelper: UserHelper) {
        self.projectId = projectId
        self.projectName = projectName
        self.networking = networking
        self.userHelper = userHelper
    }
    
    func start() {
        let taskViewModel = TaskListViewModel(networking: self.networking, coordinator: self)
        let taskList = TaskListViewController(viewModel: taskViewModel)
        taskList.tabBarItem = UITabBarItem(title: "Tasks",
                                           image: UIImage(systemName: "list.bullet"),
                                           selectedImage: nil)
        
        let projectProperties = ProjectPropertiesViewController()
        projectProperties.tabBarItem = UITabBarItem(title: "Properties",
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
        
        tabBarController.selectedIndex = 0
    }
}
