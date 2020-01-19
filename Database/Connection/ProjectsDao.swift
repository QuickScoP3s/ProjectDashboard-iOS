//
//  ProjectsDao.swift
//  Database
//
//  Created by Waut Wyffels on 16/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import Core
import SQLite

public class ProjectsDAO: DAO {
    public typealias T = Project
    
    public let db: Connection
    public let table: Table
    
    public let id = Expression<Int>("id")
    public let name = Expression<String>("name")
    public let lastEdited = Expression<Date>("lastEdited")
    public let teamId = Expression<Int>("teamId")
    public let ownerId = Expression<Int>("ownerId")
    public let contact = Expression<ContactInfo>("contact")
    
    init(_ db: Connection) {
        self.db = db
        self.table = Table("projects")
    }
    
    public func create() throws {
        do {
            try db.run(table.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(lastEdited)
                t.column(teamId)
                t.column(ownerId)
                t.column(contact)
            })
        }
        catch {
            throw DatabaseError.tableCreationFailed
        }
    }
    
    public func getById(_ id: Int) throws -> Project? {
        let filter = table.where(self.id == id)
        return try getFirst(fromFilter: filter)
    }
}
