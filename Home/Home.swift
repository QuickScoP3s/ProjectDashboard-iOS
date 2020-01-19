//
//  Home.swift
//  Home
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Database

public class Home: Feature {
    private let homeCoord: HomeCoordinator
    public var coordinator: Coordinator {
        return homeCoord
    }

    public init(networking: Core.Networking, database: AppDatabase, userHelper: UserHelper) {
        self.homeCoord = HomeCoordinator(networking: networking, database: database, userHelper: userHelper)
    }
    
    public func start(on viewcontroller: UIViewController?) {
        homeCoord.parentViewController = viewcontroller
        coordinator.start()
    }
}
