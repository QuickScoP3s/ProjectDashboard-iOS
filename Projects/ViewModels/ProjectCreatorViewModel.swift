//
//  ProjectCreatorViewModel.swift
//  Projects
//
//  Created by Waut Wyffels on 09/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import UIKit
import Core
import Networking

class ProjectCreatorViewModel: NSObject {
	
	private let teamsService: TeamsService
	private let projectsService: ProjectsService
	private weak var coordinator: ProjectsCoordinator?
	
	var teams: [Team]?
	var selectedRow: Int = 0
	
	init(networking: Networking, coordinator: ProjectsCoordinator) {
		self.coordinator = coordinator
		
		self.teamsService = TeamsService(networking: networking)
		self.projectsService = ProjectsService(networking: networking)
	}
	
	func fetchTeamsForUser(completion: @escaping ((Result<Bool, Error>) -> Void)) {
		teamsService.getTeams() { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let items):
					self.teams = items
					completion(Result.success(items.count > 0))
			}
		}
	}
	
	func createProject(name: String, contactInfo: ContactInfo, completion: @escaping ((Result<Void, Error>) -> Void)) {
		guard let team = teams?[selectedRow] else { return }
		
		let project = ProjectDTO(name: name, teamId: team.id, contactPerson: contactInfo)
		projectsService.post(project: project) { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let item):
					completion(Result.success(()))
					
					self.coordinator?.refreshProjectsOverview()
					self.coordinator?.presentProjectDetails(withId: item.id, projectName: item.name)
			}
		}
	}
}

extension ProjectCreatorViewModel: UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		// Make sure to always display at least 1 item
		// -> If 'teams' is empty: "No teams available"
		
		return max(teams?.count ?? 0, 1)
	}
}

extension ProjectCreatorViewModel: UIPickerViewDelegate {
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		guard teams != nil && teams!.count > 0 else {
			return "No teams available"
		}
		
		return teams?[row].name
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedRow = row
	}
}
