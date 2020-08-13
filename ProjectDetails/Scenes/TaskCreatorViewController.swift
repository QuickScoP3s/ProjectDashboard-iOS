//
//  TaskCreatorViewController.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 11/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Components
import LPSnackbar

class TaskCreatorViewController: UIViewController {
	private let viewModel: TaskCreatorViewModel
	
	@IBOutlet weak var txtTitle: UITextField!
	@IBOutlet weak var txtDescription: UITextView!
	@IBOutlet weak var btnSave: UIButton!
	
	// MARK: Init
	
	init(viewModel: TaskCreatorViewModel) {
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
		btnSave.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
		
		txtTitle.addTarget(self, action: #selector(titleChanged(_:)), for: .editingChanged)
		
		if viewModel.taskId != nil {
			loadTask()
		}
	}
	
	func loadTask() {
		view.activityIndicator.startAnimating()
		
		viewModel.fetchTaskDetails { result in
			switch result {
				case .failure(let error):
					print("😓 \(error.localizedDescription)")
				case .success(let task):
					DispatchQueue.main.async {
						self.txtTitle.text = task.title
						self.txtDescription.text = task.description
						self.btnSave.isEnabled = true
					}
			}
			
			self.view.activityIndicator.stopAnimating()
		}
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
		
		viewModel.saveTask(title: title, description: description) { result in
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
