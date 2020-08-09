//
//  UIViewController.swift
//  Utils
//
//  Created by Waut Wyffels on 08/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
