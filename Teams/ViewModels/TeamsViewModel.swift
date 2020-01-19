//
//  ProjectsViewModel.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Database
import Networking

class TeamsViewModel: NSObject {
    private let networking: Networking
    private let database: AppDatabase
    private let userHelper: UserHelper
    private weak var coordinator: TeamsCoordinator?
    
    var items: [Team]?

    init(networking: Networking, database: AppDatabase, userHelper: UserHelper, coordinator: TeamsCoordinator) {
        self.networking = networking
        self.database = database
        self.userHelper = userHelper
        self.coordinator = coordinator
    }
    
    func fetchTeams(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        let teamsService = TeamsService(networking: self.networking)
        
        teamsService.getTeams() { result in
            switch result {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success(let items):
                self.items = items
                completionHandler(Result.success(()))
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension TeamsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = items?[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        cell.textLabel?.text = team?.name
        cell.detailTextLabel?.text = "Members: \((team?.memberIds.count ?? 0) + 1)" // count + 1 for leader (who's not included)
        return cell
    }
}

// MARK: - UITableViewDataSource

extension TeamsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
