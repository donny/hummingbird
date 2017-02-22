//
//  ListItem.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class ListItem: NSCollectionViewItem {
    @IBOutlet var cardCollectionView: NSCollectionView!
    @IBOutlet var name: NSTextField!

    var board: Board?
    var cards: [Card]? {
        didSet {
            cardCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.masksToBounds = true
        view.layer?.cornerRadius = 8.0
        view.layer?.borderWidth = 1.0
        view.layer?.borderColor = NSColor.gray.cgColor
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.scrollDirection = .vertical
        cardCollectionView.collectionViewLayout = flowLayout
        cardCollectionView.backgroundColors = [NSColor.windowBackgroundColor]
    }
}

extension ListItem : NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards?.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "CardItem", for: indexPath)
        guard let cardItem = item as? CardItem else { return item }
        
        cardItem.name.stringValue = cards?[indexPath.item].name ?? ""
        cardItem.labels = cards?[indexPath.item].idLabels.flatMap({ idLabel in
            return board?.labelsDictionary?[idLabel]
        })
        cardItem.members = cards?[indexPath.item].idMembers.flatMap({ idMember in
            return board?.membersDictionary?[idMember]
        })

        return cardItem
    }
}

extension ListItem : NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 276.0, height: 124.0)
    }
}
