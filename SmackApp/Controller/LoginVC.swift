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
    @IBOutlet weak var spinnerBg: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        setupView()
    }
    
    func setupView() {
        self.spinnerBg.isHidden = true
        self.spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @IBAction func onCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "SignUpSegue", sender: nil)
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        spinnerBg.isHidden = false
        spinner.isHidden = false
        spinner.startAnimating()
        guard let email = usernameTxt.text, email != "", let pass = passwordTxt.text, pass != "" else { return }
        AuthService.instance.loginUser(email: email, password: pass, completion: { (logged) in
            if logged {
                AuthService.instance.findUserByEmail { (user) in
                    if user {
                        self.spinnerBg.isHidden = true
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGED, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
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
