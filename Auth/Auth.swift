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
    public var authenticatedCallback: (() -> Void)?
    
    private var authCoord: AuthCoordinator
    public var coordinator: Coordinator {
        return authCoord
    }

    public init(networking: Core.Networking, userHelper: UserHelper) {
        self.authCoord = AuthCoordinator(networking: networking, userHelper: userHelper)
    }
    
    public func start(on viewcontroller: UIViewController?) {
        authCoord.parentViewController = viewcontroller
        authCoord.delegate = self
        coordinator.start()
    }
}

// MARK: - CoordinatorDelegate

extension Auth: CoordinatorDelegate {
    public func didFinish(coordintor: Coordinator) {
        if authenticatedCallback != nil {
            authenticatedCallback!()
        }
    }
}
