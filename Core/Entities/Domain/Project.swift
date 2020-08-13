//
//  Project.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 22/10/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation

public class Project: Codable {
	
	public let id: Int
	public let name: String
	
	public let teamId: Int
	public let team: Team
	
	public let lastEdit: Date
	public let contactPerson: ContactInfo
}
