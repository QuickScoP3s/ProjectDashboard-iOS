//
//  TaskList.swift
//  Projects
//
//  Created by Waut Wyffels on 10/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

public class ProjectDetails: Feature {
    private let projectDetailsCoord: ProjectDetailsCoordinator
    public var coordinator: Coordinator {
        return projectDetailsCoord
    }

    public init(projectId: Int, projectName: String, networking: Core.Networking, userHelper: UserHelper) {
        self.projectDetailsCoord = ProjectDetailsCoordinator(projectId: projectId, projectName: projectName, networking: networking, userHelper: userHelper)
    }
    
    public func start(on viewcontroller: UIViewController?) {
        projectDetailsCoord.parentViewController = viewcontroller
        coordinator.start()
    }
}
