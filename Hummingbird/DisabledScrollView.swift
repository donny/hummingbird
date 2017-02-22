//
//  DisabledScrollView.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class DisabledScrollView: NSScrollView {
    override func scrollWheel(with theEvent: NSEvent) {
        self.nextResponder?.scrollWheel(with: theEvent)
    }
}
