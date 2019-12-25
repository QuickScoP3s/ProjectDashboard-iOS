//
//  Auth$.swift
//  Auth
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit
import Core

public class Auth: Feature {
    private var coordinator: AuthCoordinator?
    private let networking: Core.Networking
    private var childCoordinators: [Coordinator] = []

    public init(networking: Core.Networking) {
        self.networking = networking
    }
    
    public func start(on viewcontroller: UIViewController?) {
        coordinator = AuthCoordinator(networking: self.networking, rootViewController: viewcontroller)
        coordinator?.delegate = self
        
        if let coordinator = coordinator {
            childCoordinators.append(coordinator)
        }
        
        coordinator?.start()
    }
}

// MARK: - CoordinatorDelegate

extension Auth: CoordinatorDelegate {
    public func didFinish(coordintor: Coordinator) {
        childCoordinators.removeFirst()
    }
}
