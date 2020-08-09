//
//  ProjectsViewModel.swift
//  Projects
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking

class TeamsViewModel: NSObject {
    
    private let teamsService: TeamsService
    private let userHelper: UserHelper
    private weak var coordinator: TeamsCoordinator?
    
    var items: [Team]?
    
    init(networking: Networking, userHelper: UserHelper, coordinator: TeamsCoordinator) {
        self.teamsService = TeamsService(networking: networking)
        self.userHelper = userHelper
        self.coordinator = coordinator
    }
    
    func fetchTeams(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
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
    
    func addTeam(name: String, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        let user = userHelper.getUser()!
        let team = TeamDTO(name: name, leadId: user.id)
        
        teamsService.postTeam(team) { result in
            switch result {
            case .failure(let error):
                completionHandler(Result.failure(error))
            case .success:
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
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TeamCell")
        }
        
        cell!.textLabel?.text = team?.name
        //cell!.detailTextLabel?.text = "Members: \((team?.memberIds.count ?? 0) + 1)" // count + 1 for leader (who's not included)
        cell!.detailTextLabel?.text = "Members: 1"
        
        return cell!
    }
}

// MARK: - UITableViewDataSource

extension TeamsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
