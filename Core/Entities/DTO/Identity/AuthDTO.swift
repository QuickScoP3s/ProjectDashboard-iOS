//
//  AuthDTO.swift
//  Core
//
//  Created by Waut Wyffels on 17/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

public struct AuthDTO: Codable {
    public let token: String
    
    // Base64 Encoded image
    public let picture: String?
}
