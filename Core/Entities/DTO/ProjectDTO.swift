//
//  ProjectDTO.swift
//  Core
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public struct ProjectDTO: Codable {
    
    public let id: Int
    public let name: String
    public let teamId: Int
    public let contactPerson: ContactInfo
    
    public init(id: Int = 0, name: String, teamId: Int, contactPerson: ContactInfo) {
        self.id = id
        self.name = name
        self.teamId = teamId
        self.contactPerson = contactPerson
    }
}
