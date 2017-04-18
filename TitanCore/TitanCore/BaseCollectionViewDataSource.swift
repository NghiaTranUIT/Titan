//
//  BaseCollectionViewDataSource.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import Cocoa

open class BaseCollectionViewDataSource: NSObject {
    
    //
    // MARK: - Variable
    public weak var delegate: BaseCollectionViewDataSourceProtocol?
    public private(set) var collectionView: NSCollectionView!
    
    //
    // MARK: - Initialization
    public init(collectionView: NSCollectionView) {
        super.init()
        
        self.collectionView = collectionView
        self.initCollectionView()
    }
}

//
// MARK: - Private
extension BaseCollectionViewDataSource {
    
    fileprivate func initCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

//
// MARK: - NSCollectionViewDataSource
extension BaseCollectionViewDataSource: NSCollectionViewDataSource {
    
    open func numberOfSections(in collectionView: NSCollectionView) -> Int {
        
        // Need override
        return 0
    }
    
    open func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Need override
        return 0
    }
    
    open func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // Need override
        return NSCollectionViewItem()
    }
    
    open func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        
        // Need override
        return NSView()
    }
}

//
// MARK: - NSCollectionViewDelegate
extension BaseCollectionViewDataSource: NSCollectionViewDelegate {
    
    open func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        // Need override
    }
    
    open func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        
    }
}
