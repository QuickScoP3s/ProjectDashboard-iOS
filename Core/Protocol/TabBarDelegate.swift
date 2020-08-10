//
//  TabBarDelegate.swift
//  Core
//
//  Created by Waut Wyffels on 10/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public protocol TabBarDelegate: class {
    func tabChanged(selectedIndex: Int)
}
