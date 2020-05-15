//
//  AddChannelVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 15/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxt.delegate = self
        descriptionTxt.delegate = self
        
        setupView()
    }

    func setupView() {
        nameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER])
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UIGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func onCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreateTapped(_ sender: Any) {
    }
}

// MARK: - Keyboard Methods
extension AddChannelVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nxtTxtField = view.viewWithTag(textField.tag + 1) as? UITextField, nxtTxtField.tag <= 7 {
            nxtTxtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
