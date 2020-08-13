//
//  ProjectTaskDTO.swift
//  Core
//
//  Created by Waut Wyffels on 13/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public struct ProjectTaskDTO: Codable {
	
	public let title: String
	public let description: String?
	public let projectId: Int
	
	public init(title: String, description: String?, projectId: Int) {
		self.title = title
		self.description = description
		self.projectId = projectId
	}
}
