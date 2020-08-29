//
//  TeamDetailsViewController.swift
//  Teams
//
//  Created by Waut Wyffels on 28/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController {
	
	// MARK: Init
	
	init() {
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "TeamDetailsView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
