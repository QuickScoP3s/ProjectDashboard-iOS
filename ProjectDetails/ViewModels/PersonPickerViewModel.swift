//
//  PersonPickerViewModel.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 20/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking
import Components

protocol PersonPickerDelegate: class {
	func personPicked(_ person: User)
}

class PersonPickerViewModel: NSObject {
	
	private let projectId: Int
	private let projectsService: ProjectsService
	
	public weak var delegate: PersonPickerDelegate?
	
	var teamMembers: [User]?
	var filteredResults: [User]?
	
	init(projectId: Int, networking: Networking) {
		self.projectId = projectId
		self.projectsService = ProjectsService(networking: networking)
	}
	
	func fetchTeam(completion: @escaping ((Result<Void, Error>) -> Void)) {
		projectsService.getProject(byId: self.projectId) { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let item):
					self.teamMembers = [item.team.lead]
					self.teamMembers?.append(contentsOf: item.team.members)
					self.filteredResults = self.teamMembers
					
					completion(Result.success(()))
			}
		}
	}
}

// MARK: - UITableViewDataSource

extension PersonPickerViewModel: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredResults?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
		
		guard let person = filteredResults?[indexPath.row] else {
			return cell
		}
		
		cell.profileImage?.image = UIImage(named: "Profile")
		cell.nameLabel?.text = "\(person.firstName) \(person.lastName)"
		cell.emailLabel?.text = person.email
		
		return cell
	}
}

// MARK: - UITableViewDataSource

extension PersonPickerViewModel: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if let people = filteredResults {
			let person = people[indexPath.row]
			delegate?.personPicked(person)
		}
	}
}

// MARK: - Filter search results

extension PersonPickerViewModel {
	
	func filterResults(by searchText: String) {
		guard let members = teamMembers else { return }
		
		guard !searchText.isEmpty else {
			filteredResults = teamMembers
			return
		}
		
		let lowerSearch = searchText.lowercased()
		filteredResults = members.filter({ user -> Bool in
			return user.firstName.lowercased().starts(with: lowerSearch) ||
				user.lastName.lowercased().starts(with: lowerSearch) ||
				user.email.lowercased().contains(lowerSearch)
		})
	}
}
