//
//  Project.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 22/10/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation

public struct Project: Codable {
    
    public let id: Int
    public let name: String
    public let lastEdited: Date
    public let teamId: Int
    public let ownerId: Int
    public let contact: ContactInfo
    
    // MARK: - Repository variables
    public var team: Team? = nil
    public var owner: Company? = nil
    public var taskList: [ProjectTask] = [ProjectTask]()
}
