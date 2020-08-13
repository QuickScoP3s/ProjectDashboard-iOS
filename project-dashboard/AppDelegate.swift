//
//  AppDelegate.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var appCoordinator: AppCoordinator?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		let frame = UIScreen.main.bounds
		let window = UIWindow(frame: frame)
		
		// Start coordinator
		let appCoordinator = AppCoordinator(window: window)
		appCoordinator.start()
		
		self.window = window
		self.appCoordinator = appCoordinator
		
		IQKeyboardManager.shared.enable = true
		
		#if DEBUG
		NetworkActivityLogger.shared.level = .debug
		NetworkActivityLogger.shared.startLogging()
		#endif
		
		return true
	}
}

