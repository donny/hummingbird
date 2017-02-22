//
//  SplitViewController.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    var masterViewController: MasterViewController? {
        return splitViewItems.first?.viewController as? MasterViewController
    }
    
    var boardViewController: BoardViewController? {
        return splitViewItems.last?.viewController as? BoardViewController
    }
}
