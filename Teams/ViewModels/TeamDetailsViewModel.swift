//
//  TeamDetailsViewModel.swift
//  Teams
//
//  Created by Waut Wyffels on 30/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking
import Components

class TeamDetailsViewModel: NSObject {
	
	let teamId: Int
	
	var teamName: String?
	var teamLeader: String?
	var memberCount: Int?
	
	private let teamsService: TeamsService
	
	var sections: [UserSection]?
	
	init(teamId: Int, networking: Networking) {
		self.teamId = teamId
		self.teamsService = TeamsService(networking: networking)
	}
	
	func fetchTeam(completion: @escaping ((Result<Team, Error>) -> Void)) {
		teamsService.getTeam(byId: self.teamId) { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let team):
					var members = [team.lead]
					members.append(contentsOf: team.members)
					
					self.teamName = team.name
					self.teamLeader = team.lead.fullName
					self.memberCount = team.members.count
					
					self.sections = UserSection.group(users: members)
					self.sections?.sort { (ls: UserSection, rs) -> Bool in ls.beginLetter > rs.beginLetter }
					
					completion(Result.success(team))
			}
		}
	}
}

// MARK: - UITableViewDataSource

extension TeamDetailsViewModel: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.sections?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let userSection = self.sections?[section]
		return userSection?.users.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let section = self.sections![section]
		return String(section.beginLetter)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
		
		let section = self.sections?[indexPath.section]
		guard let person = section?.users[indexPath.row] else {
			return cell
		}
		
		cell.profileImage?.image = UIImage(named: "Profile")
		cell.nameLabel?.text = person.fullNameReverse
		cell.emailLabel?.text = person.email
		
		return cell
	}
	
}

// MARK: - UITableViewDataSource

extension TeamDetailsViewModel: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
