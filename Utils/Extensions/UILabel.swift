//
//  UILabel.swift
//  Utils
//
//  Created by Waut Wyffels on 30/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

extension UILabel {
	
	@IBInspectable
	var letterSpacing: CGFloat {
		get {
			var range:NSRange = NSMakeRange(0, self.text?.count ?? 0)
			let nr = self.attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: &range) as! NSNumber
			return CGFloat(truncating: nr)
		}
		
		set {
			let range:NSRange = NSMakeRange(0, self.text?.count ?? 0)
			
			let attributedString = NSMutableAttributedString(string: self.text ?? "")
			attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: range)
			self.attributedText = attributedString
		}
	}
}
