//
//  BoardViewController.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class BoardViewController: NSViewController {
    @IBOutlet var listCollectionView: NSCollectionView!

    var selectedBoard: Board? {
        didSet {
            configureBoardLists()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        configureCollectionView()
    }
 
    func configureBoardLists() {
        listCollectionView.reloadData()
    }
    
    private func hexStringToNSColor(_ hex:String) -> NSColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return NSColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return NSColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    private func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.scrollDirection = .horizontal
        listCollectionView.collectionViewLayout = flowLayout
    }
}

extension BoardViewController : NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedBoard?.lists?.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "ListItem", for: indexPath)
        guard let listItem = item as? ListItem else { return item }
        
        listItem.board = selectedBoard
        listItem.cards = selectedBoard?.cards?.filter({ card in
            return card.idList == selectedBoard?.lists?[indexPath.item].id
        })
        listItem.name.stringValue = selectedBoard?.lists?[indexPath.item].name ?? ""
        
        return listItem
    }
}

extension BoardViewController : NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 300.0, height: self.view.frame.height - 100.0)
    }
}
