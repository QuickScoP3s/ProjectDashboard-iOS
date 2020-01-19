//
//  TeamsDao.swift
//  Database
//
//  Created by Waut Wyffels on 19/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import Core
import SQLite

public class TeamsDAO: DAO {
    public typealias T = Team
    
    public let db: Connection
    public let table: Table
    
    public let id = Expression<Int>("id")
    public let name = Expression<String>("name")
    public let leadId = Expression<Int>("leadId")
    public let memberIds = Expression<String>("memberIdsMapped")
    
    init(_ db: Connection) {
        self.db = db
        self.table = Table("projects")
    }
    
    public func create() throws {
        do {
            try db.run(table.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(leadId)
                t.column(memberIds)
            })
        }
        catch {
            throw DatabaseError.tableCreationFailed
        }
    }
    
    public func getById(_ id: Int) throws -> Team? {
        let filter = table.where(self.id == id)
        return try getFirst(fromFilter: filter)
    }
}
