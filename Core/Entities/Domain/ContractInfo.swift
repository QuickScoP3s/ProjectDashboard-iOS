//
//  ContractInfo.swift
//  Core
//
//  Created by Waut Wyffels on 16/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import SQLite

public struct ContactInfo: Codable {
    
    public let firstName: String
    public let lastName: String
    public let email: String
    public let phoneNumber: String
    
}

extension ContactInfo: Value {
    
    // The SQLite type (TEXT)
    public static var declaredDatatype: String = String.declaredDatatype
    
    // Swift to SQLite
    public var datatypeValue: String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
    
    // SQLite to Swift
    public static func fromDatatypeValue(_ value: String) -> ContactInfo {
        return try! JSONDecoder().decode(ContactInfo.self, from: value.data(using: .utf8)!)
    }
}
