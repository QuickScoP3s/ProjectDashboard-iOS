//
//  Coordinator.swift
//  core
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation

// Delegate: Contains callback function passed via a variable.
// Also conforms to a protocol
public protocol CoordinatorDelegate: class {
    func didFinish(coordintor: Coordinator)
}

public protocol Coordinator: class {
    func start()
}

public protocol ViewControllerDelegate: class {
    func close()
}
