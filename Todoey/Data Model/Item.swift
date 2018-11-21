//
//  Item.swift
//  Todoey
//
//  Created by Greg Hughes on 11/21/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation

class Item: Codable {
//encodable means the Item type is now able to encode itself into a plist or jSON
    var title: String = ""
    var done: Bool = false
}
