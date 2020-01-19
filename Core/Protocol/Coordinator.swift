//
//  Coordinator.swift
//  core
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import UIKit

// Delegate: Contains callback function passed via a variable.
public protocol CoordinatorDelegate: class {
    func didFinish(coordintor: Coordinator)
}

public protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    
    func start()
}

// Used for popup controllers: Call close to hide the popup
public protocol ViewControllerDelegate: class {
    func close()
}
