//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking
import Database

class ProfileViewModel {
    private let database: AppDatabase
    private let userHelper: UserHelper
    private weak var coordinator: ProfileCoordinator?

    init(database: AppDatabase, userHelper: UserHelper, coordinator: ProfileCoordinator) {
        self.database = database
        self.userHelper = userHelper
        self.coordinator = coordinator
    }
    
    var user: User {
        // User is logged in by this point
        return userHelper.getUser()!
    }
    
    var userName: String {
        return "\(user.firstName) \(user.lastName)"
    }
    
    var userEmail: String {
        return user.email
    }
}
