//
//  Profile.swift
//  Profile
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Database

public class Profile: Feature {
    private let profileCoord: ProfileCoordinator
    public var coordinator: Coordinator {
        return profileCoord
    }

    public init(database: AppDatabase, userHelper: UserHelper) {
        self.profileCoord = ProfileCoordinator(database: database, userHelper: userHelper)
    }
    
    public func start(on viewcontroller: UIViewController?) {
        profileCoord.parentViewController = viewcontroller
        coordinator.start()
    }
}
