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

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let userHelper: UserHelper
    private let networking: Networking
    
    private let viewController = UIViewController()
    var rootViewController: UIViewController {
        return viewController
    }
    
    private lazy var auth: Feature = {
        let authFeature = Auth(networking: self.networking, userHelper: self.userHelper)
        authFeature.authenticatedCallback = self.presentHome
        
        return authFeature
    }()
    
    private lazy var home: Feature = {
        let homeFeature = Home(networking: self.networking, userHelper: self.userHelper)
        homeFeature.signOutCallback = self.presentLogin
        
        return homeFeature
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.userHelper = UserHelper()
        
        // Keep only 'else'-statement, if debugging on a real device or change "localhost" to <ip-address> of development machine
        #if DEBUG
            self.networking = NativeNetworking(baseUrl: "https://localhost:5001/api/", userHelper: userHelper)
        #else
            self.networking = NativeNetworking(userHelper: userHelper)
        #endif
    }
    
    func start() {
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
