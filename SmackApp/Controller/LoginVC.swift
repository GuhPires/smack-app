//
//  LoginVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 11/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
