//
//  ProfileVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 14/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func onCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
