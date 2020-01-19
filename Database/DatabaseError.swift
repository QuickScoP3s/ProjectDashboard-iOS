//
//  DatabaseError.swift
//  Database
//
//  Created by Waut Wyffels on 16/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public enum DatabaseError: Error {
    case databaseCreationFailed
    case tableCreationFailed
    case transactionFailed
}
