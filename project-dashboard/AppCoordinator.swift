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
import Networking

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let networking: Networking
    private let rootViewController = UIViewController()
    
    private lazy var auth: Feature = {
        return Auth(networking: networking)
    }()
    
    init(window: UIWindow) {
        self.window = window
        networking = NativeNetworking()
    }
    
    func start() {
        window.rootViewController = rootViewController
        //TODO Add home etc
        window.makeKeyAndVisible()
    }
}
