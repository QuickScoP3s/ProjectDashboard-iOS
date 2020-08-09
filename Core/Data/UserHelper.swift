//
//  UserHelper.swift
//  Core
//
//  Created by Waut Wyffels on 27/12/2019.
//  Copyright © 2019 Quick Development. All rights reserved.
//

import Foundation
import UIKit
import JWTDecode

public class UserHelper {
    public enum Key: String {
        case authToken = "AuthToken"
        case userPicture = "UserPicture"
        case userName = "UserName"
        case userPass = "UserPass"
    }
    
    private let data: UserDefaults?
    
    public var authToken: String? {
        return data?.string(forKey: Key.authToken.rawValue)
    }
    
    public var isSignedIn: Bool {
        return !(authToken ?? "").isEmpty
    }
    
    public init() {
        data = UserDefaults(suiteName: "UserAccount")
    }
    
    public func getUser() -> User? {
        if !isSignedIn {
            return nil
        }
        
        let picture = data?.string(forKey: Key.userPicture.rawValue)
        
        guard let jwt = try? decode(jwt: authToken!) else {
            return nil
        }
        
        let id = jwt.claim(name: "sub").integer!
        let email = jwt.claim(name: "email").string!
        let firstName = jwt.claim(name: "given_name").string!
        let lastName = jwt.claim(name: "family_name").string!
        let phoneNr = jwt.claim(name: "phone_number").string!
        
        var user = User(id: id, picture: picture, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNr)
        user.picture = picture
        
        return user
    }
    
    public func signOut() {
        guard let dictionary = data?.dictionaryRepresentation() else {
            return
        }
        
        dictionary.keys.forEach { key in
            data?.removeObject(forKey: key)
        }
    }
    
    public func setUserCredentials(email: String, password: String) {
        data?.set(email, forKey: Key.userName.rawValue)
        data?.set(password, forKey: Key.userPass.rawValue)
    }
    
    public func getUserCredentials() -> (String, String)? {
        if !isSignedIn || data == nil {
            return nil
        }
        
        let email = data!.string(forKey: Key.userName.rawValue)!
        let password = data!.string(forKey: Key.userPass.rawValue)!
        
        return (email, password)
    }
    
    public func saveUser(authToken: String, picture: String?) {
        data?.set(authToken, forKey: Key.authToken.rawValue)
        data?.set(picture ?? "", forKey: Key.userPicture.rawValue)
    }
}

public class UserPictureHelper {
    
    public static func EncodeImage(image: UIImage) -> String? {
        guard let imageData = image.pngData() else {
            return nil
        }
        
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    public static func DecodeImage(base64String str: String) -> UIImage? {
        guard let decodedData = Data(base64Encoded: str, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        return UIImage(data: decodedData)
    }
}
