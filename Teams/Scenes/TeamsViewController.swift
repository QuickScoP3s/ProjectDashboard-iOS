//
//  TeamsViewController.swift
//  project-dashboard
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import LPSnackbar
import Components
import Lottie

class TeamsViewController: UIViewController {
    private let viewModel: TeamsViewModel
    
    private let animationView = AnimationView()
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Init
    
    init(viewModel: TeamsViewModel) {
        self.viewModel = viewModel
        
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "TeamsView", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Overview"
        
        let addProjectButton = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(addTeam))
        navigationItem.setRightBarButton(addProjectButton, animated: false)
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "TeamCell")
        
        animationView.animation = Animation.named("NoTeams", bundle: Bundle.main)
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        animationView.isHidden = true
        
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        reloadTeams()
    }
    
    @objc func addTeam() {
        let alert = UIAlertController(title: "Create Team", message: nil, preferredStyle: .alert)
        alert.addTextField { inputField in
            inputField.placeholder = "Team name"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak alert] (_) in
            let teamName = alert!.textFields![0].text ?? ""
            self.viewModel.addTeam(name: teamName) { result in
                switch result {
                case .failure(let error):
                    LPSnackbar.showSnack(title: "(\(error.asAFError?.responseCode ?? 400)) Failed to create team", displayDuration: 1.0)
                case .success:
                    self.reloadTeams()
                }
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    private func reloadTeams() {
        view.activityIndicator.startAnimating()
        
        viewModel.fetchTeams() { result in
            switch result {
            case .failure(let error):
                print("😓 \(error.localizedDescription)")
            case .success(let hasTeams):
                DispatchQueue.main.async {
                    self.reloadData(showEmpty: !hasTeams)
                }
            }
            
            self.view.activityIndicator.stopAnimating()
        }
    }
    
    private func reloadData(showEmpty: Bool) {
        if showEmpty {
            animationView.isHidden = false
            animationView.play()
        }
        else {
            self.tableView.reloadData()
            animationView.isHidden = true
            animationView.stop()
        }
    }
}
