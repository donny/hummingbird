//
//  MemberItem.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class MemberItem: NSCollectionViewItem {
    @IBOutlet var initials: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.layer?.masksToBounds = true
        view.layer?.cornerRadius = 4.0
        view.layer?.borderWidth = 1.0
        view.layer?.borderColor = NSColor.lightGray.cgColor
    }
}
