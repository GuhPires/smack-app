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
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        AF.request(GET_CHANNELS_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTH_HEADERS).responseJSON { (response) in
            if response.error == nil {

//                let name = item["name"].stringValue
//                let channelDescription = item["description"].stringValue
//                let id = item["_id"].stringValue
//
//                let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
//                self.channels.append(channel)
                
                // Using Decodable Protocol
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: response.data!)
                } catch let error {
                    debugPrint(error)
                }
                
                completion(true)
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
}
