//
//  LoginVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 11/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        setupView()
    }
    
    func setupView() {
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
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
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "SignUpSegue", sender: nil)
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        guard let email = usernameTxt.text, email != "", let pass = passwordTxt.text, pass != "" else { return }
        AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
            if success {
                print("Logged in User! ", AuthService.instance.authToken)
            }
        })
    }
}

// MARK: - Keyboard Methods
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nxtTxtField = view.viewWithTag(textField.tag + 1) as? UITextField, nxtTxtField.tag <= 2 {
            nxtTxtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
