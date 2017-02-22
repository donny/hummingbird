//
//  MasterViewController.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {
    @IBOutlet var messageLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.wantsLayer = true
        messageLabel.stringValue = "Hummingbird"
        view.frame.size.width = 0 // Disable the side menu for now.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
