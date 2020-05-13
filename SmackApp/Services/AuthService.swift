//
//  AuthService.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 12/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    static let instance = AuthService()
    
    // MARK: - User Defaults
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // MARK: - Requests
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail: String = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADERS).responseString { (response) in
//            print("RESPONSE: ", response)
            
            if response.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail: String = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADERS).responseJSON { (response) in
//            print("RESPONSE: ", response)
            
            if response.error == nil {
                if let json = response.value as? Dictionary<String, Any> {
                    if let email = json["user"] as? String {
                        self.userEmail = email
                    }

                    if let token = json["token"] as? String {
                        self.authToken = token
                    }
                }
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
}
