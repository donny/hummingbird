//
//  VerticalScrollView.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class VerticalScrollView: NSScrollView {
    override func scrollWheel(with theEvent: NSEvent) {
        if (theEvent.scrollingDeltaX == 0 || theEvent.scrollingDeltaX == -1) && theEvent.scrollingDeltaY == 0 {
            self.nextResponder?.scrollWheel(with: theEvent)
        } else {
            super.scrollWheel(with: theEvent)
        }
    }
}
