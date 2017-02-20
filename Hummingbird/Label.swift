//
//  Label.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 21/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Foundation
import Cocoa

struct Label {
    var id: String
    var idBoard: String
    var name: String
    var color: String
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let id = dictionary["id"] as? String,
            let idBoard = dictionary["idBoard"] as? String,
            let name = dictionary["name"] as? String,
            let color = dictionary["color"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.idBoard = idBoard
        self.name = name
        self.color = color
    }
}

enum LabelColor: String {
    case green
    case yellow
    case orange
    case red
    case purple
    case blue
    case sky
    case lime
    case pink
    case black
    
    func color() -> NSColor {
        switch self {
        case .green:
            return NSColor(red: 76/255.0, green: 175/255.0, blue: 80/255.0, alpha: 1.0)
        case .yellow:
            return NSColor(red: 255/255.0, green: 235/255.0, blue: 59/255.0, alpha: 1.0)
        case .orange:
            return NSColor(red: 255/255.0, green: 152/255.0, blue: 0/255.0, alpha: 1.0)
        case .red:
            return NSColor(red: 244/255.0, green: 67/255.0, blue: 54/255.0, alpha: 1.0)
        case .purple:
            return NSColor(red: 156/255.0, green: 39/255.0, blue: 176/255.0, alpha: 1.0)
        case .blue:
            return NSColor(red: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1.0)
        case .sky:
            return NSColor(red: 0/255.0, green: 188/255.0, blue: 212/255.0, alpha: 1.0)
        case .lime:
            return NSColor(red: 205/255.0, green: 220/255.0, blue: 57/255.0, alpha: 1.0)
        case .pink:
            return NSColor(red: 233/255.0, green: 30/255.0, blue: 99/255.0, alpha: 1.0)
        case .black:
            return NSColor(red: 158/255.0, green: 158/255.0, blue: 158/255.0, alpha: 1.0)
        }
    }
}
