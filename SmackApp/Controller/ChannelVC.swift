//
//  ChannelVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 08/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIFY_USER_DATA_DID_CHANGED, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUserInfo()
    }
    
    @objc func userDataDidChange(_ notify: Notification) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    
    // MARK: - Navigation
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}

    @IBAction func onLoginTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
}
