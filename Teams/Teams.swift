//
//  Teams.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Database

public class Teams: Feature {
    private let teamsCoord: TeamsCoordinator
    public var coordinator: Coordinator {
        return teamsCoord
    }

    public init(networking: Core.Networking, database: AppDatabase, userHelper: UserHelper) {
        self.teamsCoord = TeamsCoordinator(networking: networking, database: database, userHelper: userHelper)
    }
    
    public func start(on viewcontroller: UIViewController?) {
        teamsCoord.parentViewController = viewcontroller
        coordinator.start()
    }
}
