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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var spinnerBg: UIView!
    
    // MARK: - Global Variables
    var avatarName: String = "profileDefault"
    var avatarColor: String = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTxt.delegate = self
        emailTxt.delegate = self
        passwordTxt.delegate = self
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    func setupView() {
        self.spinnerBg.isHidden = true
        self.spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
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
        performSegue(withIdentifier: "ChannelUnwind", sender: nil)
    }
    
    @IBAction func onPickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: "AvatarPickerSegue", sender: nil)
    }
    
    @IBAction func onGenerateBackgroundTapped(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func onCreateTapped(_ sender: Any) {
        spinnerBg.isHidden = false
        spinner.isHidden = false
        spinner.startAnimating()
        guard let name = usernameTxt.text, name != "", let email = emailTxt.text, email != "", let pass = passwordTxt.text, pass != "" else { return }
        AuthService.instance.registerUser(email: email, password: pass) { (registered) in
            if registered {
                AuthService.instance.loginUser(email: email, password: pass) { (logged) in
                    if logged {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (created) in
                            if created {
                                self.spinnerBg.isHidden = true
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: "ChannelUnwind", sender: nil)
                                NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGED, object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Keyboard Methods
extension SignupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nxtTxtField = view.viewWithTag(textField.tag + 1) as? UITextField, nxtTxtField.tag <= 5 {
            nxtTxtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
