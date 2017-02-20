//
//  Card.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 21/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation

struct Card {
    var id: String
    var name: String
    var idList: String
    var idLabels: [String]
    var idMembers: [String]
    var stickers: [Sticker]
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let idList = dictionary["idList"] as? String,
            let idLabels = dictionary["idLabels"] as? Array<String>,
            let idMembers = dictionary["idMembers"] as? Array<String>,
            let stickers = dictionary["stickers"] as? Array<AnyObject>
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.idList = idList
        self.idLabels = idLabels
        self.idMembers = idMembers
        self.stickers = stickers.flatMap { sticker in
            guard let stickerDictionary = sticker as? Dictionary<String, AnyObject> else {
                return nil
            }
            print(stickerDictionary)
            return Sticker(dictionary: stickerDictionary)
        }
    }
}
