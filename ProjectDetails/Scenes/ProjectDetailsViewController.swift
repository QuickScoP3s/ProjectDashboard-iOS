//
//  ProjectDetailsViewController.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 10/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Components
import LPSnackbar

class ProjectDetailsViewController: UIViewController {
	
	private let viewModel: ProjectDetailsViewModel
	
	@IBOutlet weak var projectLabel: UILabel!
	@IBOutlet weak var teamLabel: UILabel!
	@IBOutlet weak var totalTasksView: StatsView!
	@IBOutlet weak var completionView: StatsView!
	
	// MARK: Init
	
	init(viewModel: ProjectDetailsViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "ProjectDetailsView", bundle: bundle)
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
		
		projectLabel.text = "..."
		teamLabel.text = "..."
		
		loadData()
	}
	
	@objc func editProperties() {
		
	}
	
	func loadData() {
		view.activityIndicator.startAnimating()
		
		viewModel.fetchDetails { result in
			switch result {
				case .failure(let error):
					LPSnackbar.showSnack(title: "(\(error.asAFError?.responseCode ?? 400)) Failed to load details", displayDuration: 1.0)
				case .success(let stats):
					self.setStats(stats: stats)
			}
			
			self.view.activityIndicator.stopAnimating()
		}
	}
	
	private func setStats(stats: ProjectStats) {
		projectLabel.text = stats.projectName
		teamLabel.text = "By: \(stats.teamName)"
		totalTasksView.detailsText = String(stats.totalTasks)
		
		let completedPercentage = floorf(Float(stats.completedTasks) / Float(stats.totalTasks) * 100.0)
		completionView.detailsText = String(format: "%.0f", completedPercentage) + "%"
	}
}
