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
	
	var teams: [Team]?
	
	init(networking: Networking, userHelper: UserHelper, coordinator: TeamsCoordinator) {
		self.teamsService = TeamsService(networking: networking)
		self.userHelper = userHelper
		self.coordinator = coordinator
	}
	
	func fetchTeams(completion: @escaping ((Result<Bool, Error>) -> Void)) {
		teamsService.getTeams() { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let items):
					self.teams = items
					self.teams?.sort { (lt: Team, rt: Team) -> Bool in lt.name < rt.name }
					
					completion(Result.success(items.count > 0))
			}
		}
	}
	
	func addTeam(name: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
		let user = userHelper.getUser()!
		let team = TeamDTO(name: name, leadId: user.id)
		
		teamsService.post(team: team) { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success:
					completion(Result.success(()))
			}
		}
	}
}

// MARK: - UITableViewDataSource

extension TeamsViewModel: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return teams?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath)
		
		guard let team = teams?[indexPath.row] else {
			return cell
		}
		
		cell.textLabel?.text = team.name
		cell.detailTextLabel?.text = "Members: \(team.members.count + 1)" // count + 1 for leader (who's not included)
		
		return cell
	}
}

// MARK: - UITableViewDataSource

extension TeamsViewModel: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
