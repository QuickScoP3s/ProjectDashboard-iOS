//
//  TaskDetailsViewController.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 11/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Components
import LPSnackbar
import Core

class TaskDetailsViewController: UIViewController {
	private let viewModel: TaskDetailsViewModel
	
	@IBOutlet weak var txtTitle: UITextField!
	@IBOutlet weak var txtDescription: UITextView!
	
	@IBOutlet weak var assigneeField: PersonField!
	
	@IBOutlet weak var btnSave: UIButton!
	
	// MARK: Init
	
	init(viewModel: TaskDetailsViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "TaskCreatorView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		btnSave.setBackgroundColor(color: .gray, forState: .disabled)
		
		assigneeField.delegate = self
		assigneeField.clearButtonMode = .never
		
		txtTitle.addTarget(self, action: #selector(titleChanged(_:)), for: .editingChanged)
		assigneeField.addTarget(viewModel, action: #selector(viewModel.selectAssignee), for: .touchUpInside)
		btnSave.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
		
		if viewModel.taskId != nil {
			loadTask()
		}
	}
	
	func loadTask() {
		view.activityIndicator.startAnimating()
		
		self.txtTitle.text = "Loading..."
		self.txtTitle.isEnabled = false
		self.txtDescription.isEditable = false
		
		viewModel.fetchTaskDetails { result in
			switch result {
				case .failure(let error):
					print("😓 \(error.localizedDescription)")
				case .success(let task):
					DispatchQueue.main.async {
						self.txtTitle.isEnabled = true
						self.txtDescription.isEditable = true
						
						self.txtTitle.text = task.title
						
						self.setAssignee(task.assignee)
						
						self.txtDescription.text = task.description
						self.btnSave.isEnabled = true
					}
			}
			
			self.view.activityIndicator.stopAnimating()
		}
	}
	
	private func setAssignee(_ user: User?) {
		guard let user = user else {
			assigneeField.prefixText = ""
			assigneeField.person = nil
			assigneeField.clearButtonMode = .never
			
			return
		}
		
		assigneeField.prefixText = "Assigned to:"
		assigneeField.person = user
		assigneeField.clearButtonMode = .always
	}
	
	@objc func titleChanged(_ textField: UITextField) {
		guard
			let title = txtTitle.text, !title.isEmpty
			else {
				btnSave.isEnabled = false
				return
		}
		
		btnSave.isEnabled = true
	}
	
	@objc func saveTask() {
		guard let title = txtTitle.text, let description = txtDescription.text else { return }
		
		viewModel.saveTask(title: title, description: description, assignee: assigneeField.person) { result in
			switch result {
				case .failure(let error):
					guard let afErr = error.asAFError, let code = afErr.responseCode else {
						LPSnackbar.showSnack(title: "(400) Failed to save task", displayDuration: 1.0)
						return
					}
											
					LPSnackbar.showSnack(title: "(\(code)) Failed to save task", displayDuration: 1.0)
						
				case .success:
					self.dismiss(animated: true)
			}
		}
	}
}

// MARK: - PersonPickerDelegate

extension TaskDetailsViewController: PersonPickerDelegate {
	
	func personPicked(_ person: User) {
		self.presentedViewController?.dismiss(animated: true)
		self.setAssignee(person)
	}
}

// MARK: - UITextFieldDelegate

extension TaskDetailsViewController: UITextFieldDelegate {
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		if let assigneeField = textField as? PersonField {
			assigneeField.prefixText = ""
			assigneeField.person = nil
			assigneeField.clearButtonMode = .never
		}
		
		textField.resignFirstResponder()
		return false
	}
}
