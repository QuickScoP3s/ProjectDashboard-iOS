//
//  Profile.swift
//  Profile
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

public class Profile: Feature {
	public var signOutCallback: (() -> Void)?
	
	private let profileCoord: ProfileCoordinator
	public var coordinator: Coordinator {
		return profileCoord
	}
	
	public init(userHelper: UserHelper) {
		self.profileCoord = ProfileCoordinator(userHelper: userHelper)
	}
	
	public func start(on viewcontroller: UIViewController?) {
		profileCoord.parentViewController = viewcontroller
		profileCoord.delegate = self
		coordinator.start()
	}
}

// MARK: - CoordinatorDelegate

extension Profile: CoordinatorDelegate {
	public func didFinish(coordintor: Coordinator) {
		if signOutCallback != nil {
			signOutCallback!()
		}
	}
}
