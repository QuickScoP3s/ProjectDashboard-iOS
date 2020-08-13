//
//  TeamsViewController.swift
//  Teams
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Components
import Lottie
import LPSnackbar

class ProjectsViewController: UIViewController {
	private let viewModel: ProjectsViewModel
	
	private let animationStack = UIStackView()
	private let animationView = AnimationView()
	
	private let refreshControl = UIRefreshControl()
	@IBOutlet weak var projectsTable: UITableView!
	
	// MARK: Init
	
	init(viewModel: ProjectsViewModel) {
		self.viewModel = viewModel
		
		let bundle = Bundle(for: type(of: self))
		super.init(nibName: "ProjectsView", bundle: bundle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Load View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Overview"
		
		let addProjectButton = UIBarButtonItem(title: "Create", style: .plain, target: viewModel, action: #selector(viewModel.addProject))
		navigationItem.setRightBarButton(addProjectButton, animated: false)
		
		refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
		
		projectsTable.delegate = viewModel
		projectsTable.dataSource = viewModel
		projectsTable.refreshControl = refreshControl
		projectsTable.register(SubtitleCell.self, forCellReuseIdentifier: "ProjectCell")
		
		prepareAnimationView()
		
		if viewModel.sections == nil {
			reloadProjects()
		}
	}
	
	private func prepareAnimationView() {
		animationView.animation = Animation.named("EmptyList", bundle: Bundle.main)
		animationView.loopMode = .loop
		
		let label = UILabel()
		label.numberOfLines = 0
		label.text = "Whale Whale Whale\nNo projects eh"
		label.textAlignment = .center
		
		animationStack.translatesAutoresizingMaskIntoConstraints = false
		animationView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false
		
		animationStack.axis = .vertical
		animationStack.alignment = .fill
		animationStack.distribution = .fillEqually
		
		animationStack.addSubview(animationView)
		animationStack.addSubview(label)
		view.addSubview(animationStack)
		
		animationStack.isHidden = true
		animationStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		animationStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		
		animationView.centerXAnchor.constraint(equalTo: animationStack.centerXAnchor).isActive = true
		animationView.centerYAnchor.constraint(equalTo: animationStack.centerYAnchor).isActive = true
		animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
		animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		
		label.centerXAnchor.constraint(equalTo: animationStack.centerXAnchor).isActive = true
		label.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -15).isActive = true
	}
	
	@objc func refresh(_ refreshControl: UIRefreshControl) {
		viewModel.fetchProjects() { result in
			switch result {
				case .failure:
					LPSnackbar.showSnack(title: "Failed to fetch projects...", displayDuration: 2.5)
				case .success(let hasProjects):
					DispatchQueue.main.async {
						self.reloadData(showTable: hasProjects)
					}
			}
			
			refreshControl.endRefreshing()
		}
	}
	
	func reloadProjects() {
		refreshControl.beginRefreshing()
		refresh(self.refreshControl)
	}
	
	private func reloadData(showTable: Bool) {
		if showTable {
			projectsTable.alpha = 1
			projectsTable.reloadData()
			
			animationView.stop()
			animationStack.isHidden = true
		}
		else {
			projectsTable.alpha = 0.5 // Don't hide it, so user can still "Pull-to-refresh"
			animationStack.isHidden = false
			animationView.play()
		}
	}
}
