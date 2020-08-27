//
//  PersonCell.swift
//  Components
//
//  Created by Waut Wyffels on 20/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

public class PersonCell: UITableViewCell {
	
	open private(set) var profileImage: UIImageView?
	open private(set) var nameLabel: UILabel?
	open private(set) var emailLabel: UILabel?
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		profileImage = UIImageView(frame: .init(x: 20, y: 5, width: 34, height: 34))
		profileImage?.image = UIImage(named: "Profile")
		profileImage?.layer.cornerRadius = 17
		profileImage?.layer.masksToBounds = true
		profileImage?.clipsToBounds = true
		profileImage?.contentMode = .scaleAspectFill
		contentView.addSubview(profileImage!)
		
		nameLabel = UILabel(frame: .init(x: 65, y: 5, width: 49, height: 20.5))
		nameLabel?.font = .systemFont(ofSize: 17)
		contentView.addSubview(nameLabel!)
		
		emailLabel = UILabel(frame: .init(x: 65, y: 25.5, width: 30.5, height: 14.5))
		emailLabel?.font = .systemFont(ofSize: 12)
		contentView.addSubview(emailLabel!)
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		nameLabel?.sizeToFit()
		emailLabel?.sizeToFit()
	}
}
