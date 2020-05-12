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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "LoginSegue" {
//            let controller = segue.destination as! LoginVC
//        }
//    }

    @IBAction func onLoginTapped(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
}
