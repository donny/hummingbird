//
//  WindowController.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    @IBOutlet var popUpButton: NSPopUpButton!
    @IBOutlet var progressIndicator: NSProgressIndicator!
    
    var boards: [Board]?
    let networkManager = NetworkManager()
    let preferenceManager = PreferenceManager()

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titleVisibility = .hidden
        window?.isExcludedFromWindowsMenu = true
        
        popUpButton.isEnabled = false
        popUpButton.removeAllItems()
        
        if let token = preferenceManager.trelloToken, token.isEmpty {
            let initialViewController = InitialViewController()
            window?.contentViewController = initialViewController
            return
        }
        
        progressIndicator.startAnimation(nil)
        networkManager.fetchBoards { [unowned self] boards in
            self.progressIndicator.stopAnimation(nil)
            guard let boards = boards else { return }
            
            self.boards = boards
            self.popUpButton.addItems(withTitles: boards.map { $0.name })
            if !boards.isEmpty {
                self.popUpButton.isEnabled = true
                self.boardSelected(self.popUpButton)
            }
        }
    }
    
    @IBAction func boardSelected(_ sender: AnyObject) {
        guard let
            button = sender as? NSPopUpButton,
            let splitViewController = window?.contentViewController as? SplitViewController,
            let boardViewController = splitViewController.boardViewController,
            let board = boards?[button.indexOfSelectedItem]
            else {
            return
        }
        
        progressIndicator.startAnimation(nil)
        networkManager.fetchBoard(board) { [unowned self] board in
            self.progressIndicator.stopAnimation(nil)
            guard let board = board else { return }

            boardViewController.selectedBoard = board
        }
    }
}

extension WindowController: NSWindowDelegate {
    func windowDidResize(_ notification: Notification) {
        guard let
            splitViewController = window?.contentViewController as? SplitViewController,
            let boardViewController = splitViewController.boardViewController
            else {
                return
        }
        boardViewController.configureBoardLists()
    }
}
