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

class ProfileViewModel {
	
	private let userHelper: UserHelper
	private let statsService: StatsService
	private weak var coordinator: ProfileCoordinator?
	
	var stats: UserStats?
	
	init(userHelper: UserHelper, networking: Networking, coordinator: ProfileCoordinator) {
		self.userHelper = userHelper
		self.statsService = StatsService(networking: networking)
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
	
	func fetchStats(completion: @escaping ((Result<UserStats, Error>) -> Void)) {
		statsService.getStats { result in
			if let stats = try? result.get() {
				self.stats = stats
			}
			
			completion(result)
		}
	}
	
	@objc func signOut() {
		userHelper.signOut()
		coordinator?.close()
	}
}
