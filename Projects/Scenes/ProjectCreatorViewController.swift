//
//  ProjectCreatorViewController.swift
//  Projects
//
//  Created by Waut Wyffels on 08/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import UIKit
import Core
import Components
import LPSnackbar

class ProjectCreatorViewController: UIViewController {
	private let viewModel: ProjectCreatorViewModel
	
	@IBOutlet weak var txtProjectName: UITextField!
	@IBOutlet weak var teamPicker: UIPickerView!
	
	@IBOutlet weak var txtContactFirstName: UITextField!
	@IBOutlet weak var txtContactLastName: UITextField!
	@IBOutlet weak var txtContactEmail: UITextField!
	@IBOutlet weak var txtContactPhone: UITextField!
	
	@IBOutlet weak var btnCreate: UIButton!
	
	// MARK: Init
	
	init(viewModel: ProjectCreatorViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "ProjectCreatorView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		teamPicker.delegate = self.viewModel
		teamPicker.dataSource = self.viewModel
		reloadTeams()
		
		btnCreate.addTarget(self, action: #selector(createProject), for: .touchUpInside)
		btnCreate.setBackgroundColor(color: .gray, forState: .disabled)
	}
	
	func reloadTeams() {
		teamPicker.activityIndicator.startAnimating()
		
		viewModel.fetchTeamsForUser { result in
			switch result {
				case .failure(let error):
					print("😓 \(error.localizedDescription)")
				case .success(let teamsAvailable):
					DispatchQueue.main.async {
						self.btnCreate.isEnabled = teamsAvailable
						self.teamPicker.reloadAllComponents()
				}
			}
			
			self.teamPicker.activityIndicator.stopAnimating()
		}
	}
	
	@objc func createProject() {
		guard
			let projectName = txtProjectName.text, !projectName.isEmpty,
			let contactFN = txtContactFirstName.text, !contactFN.isEmpty,
			let contactLN = txtContactLastName.text, !contactLN.isEmpty,
			let contactEmail = txtContactEmail.text, !contactEmail.isEmpty,
			let contactPhone = txtContactPhone.text, !contactPhone.isEmpty
			else {
				LPSnackbar.showSnack(title: "Please fill all details correctly", displayDuration: 1.0)
				return
		}
		
		let contactInfo = ContactInfo(firstName: contactFN, lastName: contactLN, email: contactEmail, phoneNumber: contactPhone)
		viewModel.createProject(name: projectName, contactInfo: contactInfo) { result in
			switch result {
				case .failure(let error):
					guard let afErr = error.asAFError, let code = afErr.responseCode else {
						LPSnackbar.showSnack(title: "(400) Failed to create project", displayDuration: 1.0)
						return
					}
					
					if code == 409 {
						LPSnackbar.showSnack(title: "A project with this name already exists", displayDuration: 1.0)
					}
					else {
						LPSnackbar.showSnack(title: "(\(code)) Failed to create project", displayDuration: 1.0)
				}
				case .success:
					self.dismiss(animated: true)
			}
		}
	}
}
