//
//  AppDatabase.swift
//  Database
//
//  Created by Waut Wyffels on 16/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation
import SQLite

public class AppDatabase {

    private let dbConnection: Connection
    
    public let userDao: UsersDAO
    public let projectDao: ProjectsDAO
    public let teamsDao: TeamsDAO

    public init() throws {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        do {
            self.dbConnection = try Connection("\(path)/db.sqlite3")
        } catch {
            do {
                self.dbConnection = try Connection() // If the file-database creation fails, try an in-memory database
            } catch {
                throw DatabaseError.databaseCreationFailed
            }
        }
        
        userDao = UsersDAO(dbConnection)
        try userDao.create()
        
        projectDao = ProjectsDAO(dbConnection)
        try projectDao.create()
        
        teamsDao = TeamsDAO(dbConnection)
        try teamsDao.create()
    }
}
