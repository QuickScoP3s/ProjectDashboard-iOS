//
//  TeamDetailsViewController.swift
//  Teams
//
//  Created by Waut Wyffels on 28/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Components
import LPSnackbar

class TeamDetailsViewController: UIViewController {
	
	private let viewModel: TeamDetailsViewModel
	
	@IBOutlet weak var teamNameLabel: UILabel!
	@IBOutlet weak var memberCountLabel: UILabel!
	@IBOutlet weak var teamLeaderLabel: UILabel!
	
	@IBOutlet weak var memberList: UITableView!
	
	// MARK: Init
	
	init(viewModel: TeamDetailsViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "TeamDetailsView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let editTeamButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTeam))
		editTeamButton.isEnabled = false // Currently not working
		navigationItem.setRightBarButton(editTeamButton, animated: true)
		
		setTitle()
		
		memberList.delegate = viewModel
		memberList.dataSource = viewModel
		memberList.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")
		
		loadData()
	}
	
	@objc func editTeam() {
		
	}
	
	private func setTitle() {
		if let teamName = viewModel.teamName {
			teamNameLabel.text = teamName
		}
		
		if let teamLead = viewModel.teamLeader {
			teamLeaderLabel.text = teamLead
		}
		
		if let memberCount = viewModel.memberCount {
			memberCountLabel.text = "\(String(memberCount + 1)) members" // memberCount + 1 for team leader
		}
	}
	
	private func loadData() {
		self.view.activityIndicator.startAnimating()
		
		viewModel.fetchTeam() { result in
			switch result {
				case .failure:
					LPSnackbar.showSnack(title: "Failed to fetch team members...", displayDuration: 2.5)
				case .success:
					DispatchQueue.main.async {
						self.setTitle()
						self.memberList.reloadData()
					}
			}

			self.view.activityIndicator.stopAnimating()
		}
	}
}
