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
	private let authService: AuthService
	private let userHelper: UserHelper
	private weak var coordinator: AuthCoordinator?
	
	init(networking: Networking, userHelper: UserHelper, coordinator: AuthCoordinator) {
		self.authService = AuthService(networking: networking)
		self.userHelper = userHelper
		self.coordinator = coordinator
	}
	
	func register(firstName: String,
					  lastName: String,
					  email: String,
					  phone: String,
					  password: String,
					  completionHandler: @escaping ((Result<Void, Error>) -> Void)) {

		let dto = RegisterDTO(firstName: firstName,
									 lastName: lastName,
									 email: email,
									 phoneNr: phone,
									 password: password)
		
		authService.register(with: dto) { result in
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
}
