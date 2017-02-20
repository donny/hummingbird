//
//  List.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 21/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation

struct List {
    var id: String
    var name: String
    
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
