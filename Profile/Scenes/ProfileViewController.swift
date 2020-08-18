//
//  ProfileViewController.swift
//  Profile
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Components
import LPSnackbar

class ProfileViewController: UIViewController {
	
	weak var delegate: ViewControllerDelegate?
	private let viewModel: ProfileViewModel
	
	private let refreshControl = UIRefreshControl()
	
	@IBOutlet weak var txtName: UILabel!
	@IBOutlet weak var txtEmail: UILabel!
	@IBOutlet weak var imgProfile: UIImageView!
	
	@IBOutlet weak var statProjects: StatsView!
	@IBOutlet weak var statTeams: StatsView!
	@IBOutlet weak var statTotalTasks: StatsView!
	@IBOutlet weak var statTasksInProgress: StatsView!
	@IBOutlet weak var statCompletedTasks: StatsView!
	
	@IBOutlet weak var btnSignOut: UIButton!
	
	// MARK: Init
	
	init(viewModel: ProfileViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "ProfileView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(true, animated: true)
		
		refreshControl.addTarget(self, action: #selector(loadStats), for: .valueChanged)
		view.addSubview(refreshControl)
		
		imgProfile.image = UIImage(named: "Profile")
		imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
		
		let username = viewModel.userName
		let email = viewModel.userEmail
		
		txtName.text = username
		txtEmail.text = email
		
		btnSignOut.addTarget(viewModel, action: #selector(viewModel.signOut), for: .touchUpInside)
		
		if let stats = viewModel.stats {
			setStats(stats)
		}
		
		loadStats()
	}
	
	@objc func loadStats() {
		view.activityIndicator.startAnimating()
		
		viewModel.fetchStats { result in
			switch result {
				case .failure(let error):
					LPSnackbar.showSnack(title: "(\(error.asAFError?.responseCode ?? 400)) Failed to load stats", displayDuration: 1.0)
				case .success(let stats):
					self.setStats(stats)
			}
			
			self.view.activityIndicator.stopAnimating()
		}
	}
	
	private func setStats(_ stats: UserStats) {
		self.statProjects.detailsText = String(stats.projects)
		self.statTeams.detailsText = String(stats.teams)
		self.statTotalTasks.detailsText = String(stats.assignedTasks)
		self.statTasksInProgress.detailsText = String(stats.tasksInProgress)
		self.statCompletedTasks.detailsText = String(stats.completedTasks)
	}
}
