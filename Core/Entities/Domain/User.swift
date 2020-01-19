//
//  User.swift
//  Project Dashboard
//
//  Created by Waut Wyffels on 22/10/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import UIKit
import SQLite

public struct User: Codable {
    
    public let id: Int
    public var picture: String?
    public let firstName: String
    public let lastName: String
    public let email: String
    public let phoneNumber: String
    public let companyId: Int?
    
    public var UIPicture: UIImage? {
        if picture != nil {
            return UserPictureHelper.DecodeImage(base64String: self.picture!)
        }
        
        return nil
    }
}
