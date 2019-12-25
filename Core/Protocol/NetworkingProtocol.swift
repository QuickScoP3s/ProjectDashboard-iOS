//
//  NetworkingProtocol.swift
//  core
//
//  Created by Waut Wyffels on 25/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation

public protocol Networking {
    func execute(request: Request, completionHandler: @escaping ((Result<Data?, Error>) -> Void))
}
