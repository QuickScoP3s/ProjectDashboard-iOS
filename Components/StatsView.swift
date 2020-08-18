//
//  StatsView.swift
//  Components
//
//  Created by Waut Wyffels on 16/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

@IBDesignable
public class StatsView: UIView {
	
	// MARK: Properties
	
	@IBInspectable open var text: String = "" {
		didSet {
			textLabel.text = text
		}
	}
	
	@IBInspectable open var detailsText: String = "" {
		didSet {
			detailsLabel.text = detailsText
		}
	}
	
	open private(set) lazy var textLabel: UILabel = {
		let textLabel = UILabel()
		textLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		textLabel.translatesAutoresizingMaskIntoConstraints = false
		
		return textLabel
	}()
	
	open private(set) lazy var detailsLabel: UILabel = {
		let detailsLabel = UILabel()
		detailsLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
		detailsLabel.translatesAutoresizingMaskIntoConstraints = false
		
		return detailsLabel
	}()
	
	// MARK: - Init
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	public convenience init(text: String, detailsText: String) {
		self.init(frame: .zero)
		
		self.text = text
		self.detailsText = detailsText
	}
	
	// MARK: - Methods
	
	private func setupView() {
		backgroundColor = .clear
		
		addSubview(textLabel)
		addSubview(detailsLabel)
		setupLayout()
	}
	
	private func setupLayout() {
		NSLayoutConstraint.activate([
			textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			topAnchor.constraint(equalTo: textLabel.topAnchor, constant: -10),
			textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
			
			detailsLabel.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
			detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		setupLayout()
	}
	
	public override class var requiresConstraintBasedLayout: Bool {
	  return true
	}
	
	public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
		return UIView.layoutFittingCompressedSize
	}
}
