//
//  ActivityIndicator.swift
//  Components
//
//  Created by Waut Wyffels on 08/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import UIKit

fileprivate var ActivityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"
public extension UIView {
	var activityIndicator: UIActivityIndicatorView {
		get {
			if let activityView = getAssociatedObject(&ActivityIndicatorViewAssociativeKey) as? UIActivityIndicatorView {
				return activityView
			}
			else {
				
				let activityView = UIActivityIndicatorView(style: .large)
				activityView.color = .gray
				activityView.center = center
				activityView.hidesWhenStopped = true
				activityView.autoresizingMask = [ .flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight ]
				
				addSubview(activityView)
				
				setAssociatedObject(activityView, associativeKey: &ActivityIndicatorViewAssociativeKey, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
				return activityView
			}
		}
		
		set {
			addSubview(newValue)
			setAssociatedObject(newValue, associativeKey:&ActivityIndicatorViewAssociativeKey, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
}

private extension NSObject {
	func setAssociatedObject(_ value: AnyObject?, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
		if let valueAsAnyObject = value {
			objc_setAssociatedObject(self, associativeKey, valueAsAnyObject, policy)
		}
	}
	
	func getAssociatedObject(_ associativeKey: UnsafeRawPointer) -> Any? {
		guard let valueAsType = objc_getAssociatedObject(self, associativeKey) else {
			return nil
		}
		return valueAsType
	}
}
