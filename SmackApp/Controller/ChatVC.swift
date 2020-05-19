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
    
    @IBOutlet weak var messageTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChanged(_:)), name: NOTIFY_USER_DATA_DID_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (user) in
                if user {
                    NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGED, object: nil)
                }
            }
        }
    }
    
    @objc func userDataDidChanged(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            MessageService.instance.findAllChannels { (channels) in
                if channels {
                    self.navigationItem.title = "Select a channel"
                    if MessageService.instance.channels.count > 0 {
                        MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                        self.updateWithCahnnel()
                    } else {
                        self.navigationItem.title = "No channels yet!"
                    }
                }
            }
        } else {
            navigationItem.title = "Log in to #Smack"
        }
    }
    
    @objc func channelSelected(_ notification: Notification) {
        updateWithCahnnel()
    }
    
    func updateWithCahnnel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        navigationItem.title = "#\(channelName)"
        getMessages()
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (messages) in
            if messages {
                
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func onMenuTapped(_ sender: Any) {
        performSegue(withIdentifier: "ChannelSegue", sender: nil)
    }
    
    @IBAction func onSendTapped(_ sender: Any) {
    }
}
