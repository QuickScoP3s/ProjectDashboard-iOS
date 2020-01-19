//
//  UsersTable.swift
//  Database
//
//  Created by Waut Wyffels on 16/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import Core
import SQLite

public class UsersDAO: DAO {
    public typealias T = User
    
    public let db: Connection
    public let table: Table
    
    public let id = Expression<Int>("id")
    public let picture = Expression<String?>("picture")
    public let firstName = Expression<String>("firstName")
    public let lastName = Expression<String>("lastName")
    public let email = Expression<String>("email")
    public let phoneNumber = Expression<String>("phoneNumber")
    public let companyId = Expression<Int?>("companyId")
    
    init(_ db: Connection) {
        self.db = db
        self.table = Table("users")
    }
    
    public func create() throws {
        do {
            try db.run(table.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(picture)
                t.column(firstName)
                t.column(lastName)
                t.column(email)
                t.column(phoneNumber)
                t.column(companyId)
            })
        }
        catch {
            throw DatabaseError.tableCreationFailed
        }
    }
    
    public func getById(_ id: Int) throws -> User? {
        let filter = table.where(self.id == id)
        return try getFirst(fromFilter: filter)
    }
}
