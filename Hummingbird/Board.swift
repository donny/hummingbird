//
//  Board.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 21/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation

struct Board {
    var id: String
    var name: String
    var lists: [List]?
    var listsDictionary: [String: List]?
    var cards: [Card]?
    var cardsDictionary: [String: Card]?
    var labels: [Label]?
    var labelsDictionary: [String: Label]?
    var members: [Member]?
    var membersDictionary: [String: Member]?
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.name = name
    }
}
