//
//  BaseCollectionView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/13/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

open class BaseCollectionView: NSCollectionView {

    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override open var isFlipped: Bool {
        return true
    }
}
