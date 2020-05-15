//
//  ChatVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 08/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (user) in
                if user {
                    NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGED, object: nil)
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func onMenuTapped(_ sender: Any) {
        performSegue(withIdentifier: "ChannelSegue", sender: nil)
    }
}
