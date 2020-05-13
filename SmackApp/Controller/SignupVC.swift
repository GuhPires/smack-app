//
//  SignupVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 12/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTxt.delegate = self
        emailTxt.delegate = self
        passwordTxt.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    @IBAction func onCloseTapped(_ sender: Any) {
        performSegue(withIdentifier: "ChannelUnwind", sender: nil)
    }
    
    @IBAction func onPickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func onGenerateBackgroundTapped(_ sender: Any) {
    }
    
    @IBAction func onCreateTapped(_ sender: Any) {
        guard let email = emailTxt.text, email != "", let pass = passwordTxt.text, pass != "" else { return }
        AuthService.instance.registerUser(email: email, password: pass) { (created) in
            if created {
                AuthService.instance.loginUser(email: email, password: pass) { (logged) in
                    if logged {
                        print("Logged in User! ", AuthService.instance.authToken)
                    }
                }
            }
        }
    }
}

// MARK: - Keyboard Methods
extension SignupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nxtTxtField = view.viewWithTag(textField.tag + 1) as? UITextField {
            nxtTxtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
