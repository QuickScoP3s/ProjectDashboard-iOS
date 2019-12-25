//
//  AuthService.swift
//  Networking
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Core

public class AuthService {
    
    private let baseUrl = "auth"
    private let networking: Networking
    
    public init(networking: Networking) {
        self.networking = networking
    }
    
    // MARK: - API Calls
    
    public func login(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        
    }
    
    public func register(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        
    }
}
