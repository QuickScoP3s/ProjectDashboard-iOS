//
//  PersonField.swift
//  Components
//
//  Created by Waut Wyffels on 18/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core

@IBDesignable
public class PersonField: UITextField {
	
	private var tapGestureRecognizer: UITapGestureRecognizer?
	
	// MARK: Properties
	
	@IBInspectable open var prefixText: String = "" {
		didSet {
			prefixLabel.text = prefixText
		}
	}
	
	open var person: User? = nil {
		didSet {
			if person != nil {
				self.text = "\(person!.firstName) \(person!.lastName)"
			}
			else {
				self.text = ""
			}
		}
	}
	
	open private(set) lazy var prefixLabel: UILabel = {
		let textLabel = UILabel()
		textLabel.font = UIFont.systemFont(ofSize: 14)
		textLabel.textColor = .darkGray
		textLabel.translatesAutoresizingMaskIntoConstraints = false
		
		return textLabel
	}()
	
	public override var canBecomeFocused: Bool {
		return false // Disable editing
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	public convenience init(prefixText: String) {
		self.init(frame: .zero)
		self.prefixText = prefixText
	}
	
	func setup() {
		tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
		addGestureRecognizer(tapGestureRecognizer!)
		
		addSubview(prefixLabel)
		setupLayout()
	}
	
	func setupLayout() {
		NSLayoutConstraint.activate([
			prefixLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			prefixLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
	
	@objc
	internal func handleSingleTap(_ sender: UITapGestureRecognizer) {
		self.sendActions(for: .touchUpInside)
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		setupLayout()
	}
	
	public override func textRect(forBounds bounds: CGRect) -> CGRect {
		var leftInset: CGFloat = 0
		if let prefix = prefixLabel.text, !prefix.isEmpty {
			leftInset = prefixLabel.frame.width + 7
		}
		
		let insets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
		return super.textRect(forBounds: bounds.inset(by: insets))
	}

	public override func editingRect(forBounds bounds: CGRect) -> CGRect {
		var leftInset: CGFloat = 0
		if let prefix = prefixLabel.text, !prefix.isEmpty {
			leftInset = prefixLabel.frame.width + 7
		}
		
		let insets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
		return super.textRect(forBounds: bounds.inset(by: insets))
	}
}
