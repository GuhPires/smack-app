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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
        
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
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
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
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func onMenuTapped(_ sender: Any) {
        performSegue(withIdentifier: "ChannelSegue", sender: nil)
    }
    
    @IBAction func onSendTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id, let message = messageTxt.text else { return }
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (sent) in
                if sent {
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                }
            }
        }
    }
}

// MARK: - Table View Methods
extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }
        
        return MessageCell()
    }
}
