//
//  ProjectSection.swift
//  Core
//
//  Created by Waut Wyffels on 09/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public struct ProjectSection {
	
	public let teamId: Int
	public var projects: [Project]
	
	public init(teamId: Int, projects: [Project]) {
		self.teamId = teamId
		self.projects = projects
		
		self.sortProjects()
	}
	
	public mutating func sortProjects() {
		self.projects.sort { (lp: Project, rp: Project) -> Bool in lp.lastEdit > rp.lastEdit }
	}
	
	public static func group(projects: [Project]) -> [ProjectSection] {
		let groups = Dictionary(grouping: projects) { $0.teamId }
		return groups.map(ProjectSection.init(teamId:projects:))
	}
}
