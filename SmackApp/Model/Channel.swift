//
//  Channel.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 14/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int?
}
