//
//  SocketService.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 15/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    let manager: SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
    let socket: SocketIOClient!
    
    override init() {
        socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
//            print("data: ", dataArray)
            guard let channelName = dataArray[0] as? String, let channelDesc = dataArray[1] as? String, let channelId = dataArray[2] as? String else { return }
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: 0)
//            print("New Channel: ", newChannel)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
}
