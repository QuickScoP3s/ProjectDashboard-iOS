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

class ProjectsViewModel: NSObject {
	
	private let projectsService: ProjectsService
	private weak var coordinator: ProjectsCoordinator?
	
	var sections: [ProjectSection]?
	
	init(networking: Networking, coordinator: ProjectsCoordinator) {
		self.projectsService = ProjectsService(networking: networking)
		self.coordinator = coordinator
	}
	
	func fetchProjects(completion: @escaping ((Result<Bool, Error>) -> Void)) {
		projectsService.getProjects() { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let items):
					self.sections = ProjectSection.group(projects: items)
					self.sections?.sort { (ls: ProjectSection, rs) -> Bool in ls.projects[0].lastEdit > rs.projects[0].lastEdit }
					
					completion(Result.success(items.count > 0))
			}
		}
	}
	
	@objc func addProject() {
		coordinator?.presentAddProject()
	}
}

// MARK: - UITableViewDataSource

extension ProjectsViewModel: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.sections?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let teamSection = self.sections?[section]
		return teamSection?.projects.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let section = self.sections?[section]
		return section?.projects[0].team.name
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)
		
		let section = self.sections?[indexPath.section]
		guard let project = section?.projects[indexPath.row] else {
			return cell
		}
		
		let formatter = RelativeDateTimeFormatter()
		let lastModified = formatter.localizedString(for: project.lastEdit, relativeTo: Date())
		
		cell.textLabel?.text = project.name
		cell.detailTextLabel?.text = "Last Modified: \(lastModified)"
		
		return cell
	}
}

// MARK: - UITableViewDataSource

extension ProjectsViewModel: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let section = self.sections![indexPath.section]
		let project = section.projects[indexPath.row]
		
		coordinator?.presentProjectDetails(withId: project.id, projectName: project.name)
	}
}
