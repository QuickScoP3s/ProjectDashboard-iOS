//
//  LoginViewModel.swift
//  Auth
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking

class LoginViewModel: NSObject {
    private let service: AuthService
    private weak var coordinator: AuthCoordinator?
    
    init(networking: Networking, coordinator: AuthCoordinator) {
        self.service = AuthService(networking: networking)
        self.coordinator = coordinator
    }
    
    func login(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        
    }
}
