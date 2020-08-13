//
//  HomeTabBarController.swift
//  Home
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

class HomeTabBarController: UITabBarController {
	weak var tabDelegate: TabBarDelegate?
	
	override var selectedViewController: UIViewController? {
		didSet {
			tabChangedTo(selectedIndex: selectedIndex)
		}
	}
	
	override var selectedIndex: Int {
		didSet {
			tabChangedTo(selectedIndex: selectedIndex)
		}
	}
	
	func tabChangedTo(selectedIndex: Int) {
		tabDelegate?.tabChanged(selectedIndex: selectedIndex)
	}
}
