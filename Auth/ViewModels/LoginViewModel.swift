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

class LoginViewModel {
    private let service: AuthService
    private let userHelper: UserHelper
    private weak var coordinator: AuthCoordinator?
    
    init(networking: Networking, userHelper: UserHelper, coordinator: AuthCoordinator) {
        self.service = AuthService(networking: networking)
        self.userHelper = userHelper
        self.coordinator = coordinator
    }
    
    func login(email: String, password: String, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        let dto = LoginDTO(email: email, password: password)
        
        service.login(dto: dto) { result in
            switch result {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let auth):
                self.userHelper.saveUser(authToken: auth.token, picture: auth.picture)
                self.userHelper.setUserCredentials(email: dto.email, password: dto.password)
                
                completionHandler(Result.success(()))
            }
        }
    }
    
    @objc func register() {
        coordinator?.presentRegister()
    }
}
