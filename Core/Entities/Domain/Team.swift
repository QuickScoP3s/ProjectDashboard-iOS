//
//  Team.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 19/11/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import SQLite

public class Team: Codable {
    
    public let id: Int
    public let name: String
    public let leadId: Int
    public var memberIds: MemberIds
    
    public init(id: Int = 0, name: String, leadId: Int) {
        self.id = id
        self.name = name
        self.leadId = leadId
        self.memberIds = MemberIds()
    }
    
    public var lead: User? = nil
    public var members: [User]? = nil
    
    public var memberIdsMapped: String {
        get {
            return memberIds.map { String($0) }.joined(separator: ",")
        }
        set {
            memberIds = newValue.split(separator: ",").map { Int($0)! }
        }
    }
}

public typealias MemberIds = [Int]
