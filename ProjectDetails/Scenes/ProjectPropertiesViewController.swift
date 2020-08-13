//
//  ProjectPropertiesViewController.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 10/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

class ProjectPropertiesViewController: UIViewController {
	
	// MARK: Init
	
	init() {
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "ProjectPropertiesView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editProperties))
		parent?.navigationItem.setRightBarButton(editButton, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@objc func editProperties() {
		
	}
}
