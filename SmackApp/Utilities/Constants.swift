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
let ADD_USER_URL = "\(BASE_URL)user/add"
let FIND_USER_BY_EMAIL_URL = "\(BASE_URL)user/byEmail/"
let GET_CHANNELS_URL = "\(BASE_URL)channel"
let HEADERS: HTTPHeaders = [
    "Content-Type": "application/json; charset=utf-8"
]
let AUTH_HEADERS: HTTPHeaders = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

// MARK: - User Defaults
let TOKEN_KEY = "token"
let LOGGED_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// MARK: - Notification
let NOTIFY_USER_DATA_DID_CHANGED = Notification.Name("notifyUserDataChanged")

// MARK: - Colors
let PURPLE_PLACEHOLDER = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)
