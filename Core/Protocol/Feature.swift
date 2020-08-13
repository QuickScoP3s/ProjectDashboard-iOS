//
//  Feature.swift
//  core
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit

public protocol Feature {
	var coordinator: Coordinator { get }
	
	func start(on viewcontroller: UIViewController?)
}
