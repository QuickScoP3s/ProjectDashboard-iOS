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
    
    public func login(dto: LoginDTO, completionHandler: @escaping ((Result<AuthDTO, Error>) -> Void)) {
        let url = baseUrl + "/login"
        let request = Request(url: url, method: .post, body: dto)
        
        networking.execute(request: request) { result in
            switch result {
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                    completionHandler(Result.failure(error))

                case .success(let response):
                    guard let data = response?.data else {
                        return
                    }
                    
                    do {
                        let response = try JSONDecoder().decode(AuthDTO.self, from: data)
                        completionHandler(Result.success(response))
                    }
                    catch let error {
                        completionHandler(Result.failure(error))
                    }
            }
        }
    }
    
    public func register(completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        
    }
}
