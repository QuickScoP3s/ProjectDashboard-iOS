//
//  Team.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation

public class Team: Codable {
    
    public let id: Int
    public let name: String
    
    public let leadId: Int
    public let lead: User
    
    public let members: [User]
}
