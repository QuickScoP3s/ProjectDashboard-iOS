//
//  Home.swift
//  Home
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

public class Home: Feature {
	public var signOutCallback: (() -> Void)?
	
	private let homeCoord: HomeCoordinator
	public var coordinator: Coordinator {
		return homeCoord
	}
	
	public init(networking: Core.Networking, userHelper: UserHelper) {
		self.homeCoord = HomeCoordinator(networking: networking, userHelper: userHelper)
	}
	
	public func start(on viewcontroller: UIViewController?) {
		homeCoord.parentViewController = viewcontroller
		homeCoord.delegate = self;
		coordinator.start()
	}
}

// MARK: - CoordinatorDelegate

extension Home: CoordinatorDelegate {
	public func didFinish(coordintor: Coordinator) {
		if signOutCallback != nil {
			signOutCallback!()
		}
	}
}
