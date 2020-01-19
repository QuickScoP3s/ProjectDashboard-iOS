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
    public let ownerId: Int
    public let contactPerson: ContactInfo
    
    public func toModel() -> Project {
        return Project(id: id,
                       name: name,
                       lastEdited: Date.init(),
                       teamId: teamId,
                       ownerId: ownerId,
                       contact: contactPerson)
    }
}
