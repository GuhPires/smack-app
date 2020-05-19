//
//  MessageService.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 14/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    var messages = [Message]()
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        AF.request(GET_CHANNELS_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTH_HEADERS).responseJSON { (response) in
            if response.error == nil {
                
                // Using Decodable Protocol
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: response.data!)
                } catch let error {
                    debugPrint(error)
                }
                
                NotificationCenter.default.post(name: NOTIFY_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        AF.request("\(GET_MESSAGES_URL)/\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTH_HEADERS).responseJSON { (response) in
            if response.error == nil {
                self.clearMessages()
                
                do {
                    self.messages = try JSONDecoder().decode([Message].self, from: response.data!)
                } catch let error {
                    debugPrint(error)
                }
                print("-> ", self.messages)
                completion(true)
            } else {
                debugPrint(response.error as Any)
                completion(false)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
}
