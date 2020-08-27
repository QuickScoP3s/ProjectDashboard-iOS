//
//  PersonPickerViewController.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 20/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Components

class PersonPickerViewController: UIViewController {
	private let viewModel: PersonPickerViewModel
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var userList: UITableView!
	
	// MARK: Init
	
	init(viewModel: PersonPickerViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "PersonPickerView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		searchBar.delegate = self
		searchBar.becomeFirstResponder()
		
		userList.delegate = viewModel
		userList.dataSource = viewModel
		userList.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")
		
		loadTeam()
	}
	
	func loadTeam() {
		view.activityIndicator.startAnimating()
		
		viewModel.fetchTeam { result in
			switch result {
				case .failure(let error):
					print("😓 \(error.localizedDescription)")
				case .success:
					DispatchQueue.main.async {
						self.userList.reloadData()
					}
			}
			
			self.view.activityIndicator.stopAnimating()
		}
	}
}

// MARK: - UISearchBarDelegate

extension PersonPickerViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.filterResults(by: searchText)
		userList.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.dismiss(animated: true)
	}
	
}
