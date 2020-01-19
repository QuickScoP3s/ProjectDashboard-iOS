//
//  RegisterViewModel.swift
//  Auth
//
//  Created by Waut Wyffels on 17/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking

class RegisterViewModel {
    private let service: AuthService
    private let userHelper: UserHelper
    private weak var coordinator: AuthCoordinator?
    
    init(networking: Networking, userHelper: UserHelper, coordinator: AuthCoordinator) {
        self.service = AuthService(networking: networking)
        self.userHelper = userHelper
        self.coordinator = coordinator
    }
    
    func register(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        //TODO Call networkservice
    }
}
