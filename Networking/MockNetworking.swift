//
//  MockNetworking.swift
//  Networking
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import Core

public class MockNetworking: Networking {
    public init() {}
    
    public func execute(request: Request, completionHandler: @escaping ((Result<Data?, Error>) -> Void)) {
        guard let path = Bundle.main.path(forResource: "result", ofType: "json") else {
            completionHandler(Result.failure(NetworkError.unableToDecode))
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            completionHandler(Result.success(data))
        } catch let error {
            completionHandler(Result.failure(error))
        }
    }
}
