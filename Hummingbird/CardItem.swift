//
//  CardItem.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import Cocoa

class CardItem: NSCollectionViewItem {
    @IBOutlet var labelCollectionView: NSCollectionView!
    @IBOutlet var memberCollectionView: NSCollectionView!
    @IBOutlet var name: NSTextField!

    var labels: [Label]? {
        didSet {
            labelCollectionView.reloadData()
        }
    }

    var members: [Member]? {
        didSet {
            memberCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.layer?.masksToBounds = true
        view.layer?.cornerRadius = 8.0
        view.layer?.borderWidth = 1.0
        view.layer?.borderColor = NSColor.lightGray.cgColor
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let labelFlowLayout = NSCollectionViewFlowLayout()
        labelFlowLayout.sectionInset = EdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        labelFlowLayout.minimumInteritemSpacing = 6.0
        labelFlowLayout.minimumLineSpacing = 6.0
        labelFlowLayout.scrollDirection = .horizontal
        labelCollectionView.collectionViewLayout = labelFlowLayout
        labelCollectionView.enclosingScrollView?.borderType = .noBorder
        
        let memberFlowLayout = NSCollectionViewFlowLayout()
        memberFlowLayout.sectionInset = EdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        memberFlowLayout.minimumInteritemSpacing = 6.0
        memberFlowLayout.minimumLineSpacing = 6.0
        memberFlowLayout.scrollDirection = .horizontal
        memberCollectionView.collectionViewLayout = memberFlowLayout
        memberCollectionView.enclosingScrollView?.borderType = .noBorder
    }
}

extension CardItem : NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == labelCollectionView {
            return labels?.count ?? 0
        } else {
            return members?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        if collectionView == labelCollectionView {
            let item = collectionView.makeItem(withIdentifier: "LabelItem", for: indexPath)
            guard let labelItem = item as? LabelItem else { return item }
            
            if let color = labels?[indexPath.item].color, let labelColor = LabelColor(rawValue: color) {
                labelItem.view.layer?.backgroundColor = labelColor.color().cgColor
            }

            return labelItem
        } else {
            let item = collectionView.makeItem(withIdentifier: "MemberItem", for: indexPath)
            guard let memberItem = item as? MemberItem else { return item }
            
            memberItem.initials.stringValue = members?[indexPath.item].initials ?? ""
            
            return memberItem
        }
    }
}

extension CardItem : NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        if collectionView == labelCollectionView {
            return NSSize(width: 40.0, height: 10.0)
        } else {
            return NSSize(width: 30.0, height: 30.0)
        }
    }
}
