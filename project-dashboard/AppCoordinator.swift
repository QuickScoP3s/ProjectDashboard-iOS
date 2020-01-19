//
//  AppCoordinator.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import UIKit
import Core
import Auth
import Home
import Networking
import Database

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let userHelper: UserHelper
    private let networking: Networking
    private let database: AppDatabase
    
    private let viewController = UIViewController()
    var rootViewController: UIViewController {
        return viewController
    }
    
    private lazy var auth: Feature = {
        var authFeature = Auth(networking: self.networking, userHelper: self.userHelper)
        authFeature.authenticatedCallback = self.presentHome
        
        return authFeature
    }()
    
    private lazy var home: Feature = {
        return Home(networking: self.networking, database: self.database, userHelper: self.userHelper)
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.userHelper = UserHelper()
        self.networking = NativeNetworking(userHelper: userHelper)

        self.database = try! AppDatabase()
    }
    
    func start() {
        viewController.view.backgroundColor = .systemBackground
        window.rootViewController = rootViewController
        
        if !userHelper.isSignedIn {
            presentLogin()
        }
        else {
            presentHome()
        }
        
        window.makeKeyAndVisible()
    }
    
    func presentLogin() {
        DispatchQueue.main.async {
            self.auth.start(on: self.rootViewController)
        }
    }
    
    func presentHome() {
        DispatchQueue.main.async {
            self.home.start(on: self.rootViewController)
        }
    }
}
