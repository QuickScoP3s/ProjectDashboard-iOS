//
//  ProjectDTO.swift
//  Core
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public struct ProjectDTO: Codable {
	
	public let name: String
	public let teamId: Int
	public let contactPerson: ContactInfo
	
	public init(name: String, teamId: Int, contactPerson: ContactInfo) {
		self.name = name
		self.teamId = teamId
		self.contactPerson = contactPerson
	}
}
