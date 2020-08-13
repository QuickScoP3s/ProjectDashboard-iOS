//
//  Projects.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

public class Projects: Feature {
	private let projectsCoord: ProjectsCoordinator
	public var coordinator: Coordinator {
		return projectsCoord
	}
	
	public init(networking: Core.Networking, userHelper: UserHelper) {
		self.projectsCoord = ProjectsCoordinator(networking: networking, userHelper: userHelper)
	}
	
	public func start(on viewcontroller: UIViewController?) {
		projectsCoord.parentViewController = viewcontroller
		coordinator.start()
	}
}
