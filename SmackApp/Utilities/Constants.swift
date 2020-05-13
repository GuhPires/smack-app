//
//  Constants.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 12/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Typealieases
typealias CompletionHandler = (_ Success: Bool) -> ()

// MARK: - URLs
let BASE_URL = "https://slack-app-chat.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let HEADERS: HTTPHeaders = [
    "Content-Type": "application/json; charset=utf-8"
]

// MARK: - User Defaults
let TOKEN_KEY = "token"
let LOGGED_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
