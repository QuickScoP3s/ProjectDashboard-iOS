//
//  TableProtocol.swift
//  Database
//
//  Created by Waut Wyffels on 16/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import SQLite

public protocol DAO {
    associatedtype T: Codable
    
    var db: Connection { get }
    var table: Table { get }
    
    func create() throws
    func getById(_ id: Int) throws -> T?
}

public extension DAO {
    func getAll() throws -> [T] {
        do {
            let users: [T] = try db.prepare(table).map { row in
                return try row.decode()
            }
            
            return users
        }
        catch {
            throw DatabaseError.transactionFailed
        }
    }
    
    func insert(item: T) throws {
        do {
            try db.run(table.insert(item))
        } catch {
            throw DatabaseError.transactionFailed
        }
    }
    
    func insertAll(items: T...) throws {
        do {
            try db.transaction {
                for item in items {
                    try db.run(table.insert(item))
                }
            }
        } catch {
            throw DatabaseError.transactionFailed
        }
    }
    
    func insertAll(items: [T]) throws {
        do {
            try db.transaction {
                for item in items {
                    try db.run(table.insert(item))
                }
            }
        } catch {
            throw DatabaseError.transactionFailed
        }
    }
    
    func getFirst(fromFilter filter: Table) throws -> T? {
        do {
            let row = try db.pluck(filter)
            guard row == nil else {
                return nil
            }
            
            return try row!.decode()
        } catch {
            throw DatabaseError.transactionFailed
        }
    }
    
    func update(item: T) throws {
        
    }
    
    func delete(item: T) throws {
        
    }
}
