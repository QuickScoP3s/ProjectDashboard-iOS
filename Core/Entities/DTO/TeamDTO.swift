//
//  TeamDTO.swift
//  Core
//
//  Created by Waut Wyffels on 09/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public struct TeamDTO: Codable {
	
	public let name: String
	public let leadId: Int
	
	public init(name: String, leadId: Int) {
		self.name = name
		self.leadId = leadId
	}
}
