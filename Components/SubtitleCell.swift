//
//  SubtitleCell.swift
//  Components
//
//  Created by Waut Wyffels on 08/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

public class SubtitleCell: UITableViewCell {
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
