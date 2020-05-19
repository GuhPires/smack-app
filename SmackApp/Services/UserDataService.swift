//
//  UserDataService.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 12/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import Foundation
import UIKit

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id: String = ""
    public private(set) var avatarColor: String = ""
    public private(set) var avatarName: String = ""
    public private(set) var email: String = ""
    public private(set) var name: String = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a: NSString?
        r = scanner.scanUpToCharacters(from: comma) as NSString?
        g = scanner.scanUpToCharacters(from: comma) as NSString?
        b = scanner.scanUpToCharacters(from: comma) as NSString?
        a = scanner.scanUpToCharacters(from: comma) as NSString?
        let defaultColor = UIColor.lightGray
        
        guard let red = r, let green = g, let blue = b, let alpha = a else { return defaultColor }
        
        return UIColor(red: CGFloat(red.doubleValue), green: CGFloat(green.doubleValue), blue: CGFloat(blue.doubleValue), alpha: CGFloat(alpha.doubleValue))
    }
    
    func logoutUser() {
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
}
