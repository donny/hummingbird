//
//  Sticker.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 21/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation

struct Sticker {
    var id: String
    var image: String
    var imageUrl: String
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let id = dictionary["id"] as? String,
            let image = dictionary["image"] as? String,
            let imageUrl = dictionary["imageUrl"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.image = image
        self.imageUrl = imageUrl
    }
}
