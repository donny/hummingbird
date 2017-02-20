//
//  Member.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 21/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation

struct Member {
    var id: String
    var avatarHash: String // The API could return null.
    var initials: String
    var fullName: String
    var username: String
    var memberType: String
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let id = dictionary["id"] as? String,
            let initials = dictionary["initials"] as? String,
            let fullName = dictionary["fullName"] as? String,
            let username = dictionary["username"] as? String,
            let memberType = dictionary["memberType"] as? String
            else {
                return nil
        }
        
        let avatarHash = dictionary["avatarHash"] as? String ?? ""
        
        self.id = id
        self.avatarHash = avatarHash
        self.initials = initials
        self.fullName = fullName
        self.username = username
        self.memberType = memberType
    }
}
