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
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ChannelSegue" {
//            let controller = segue.destination as! ChannelVC
//        }
//    }
    
    // MARK: - Actions
    @IBAction func onMenuTapped(_ sender: Any) {
        performSegue(withIdentifier: "ChannelSegue", sender: nil)
    }
}
