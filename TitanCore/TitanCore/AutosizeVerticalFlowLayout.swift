//
//  AutosizeVerticalFlowLayout.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

open class AutosizeVerticalFlowLayout: NSCollectionViewFlowLayout {

    //
    // MARK: - Variable
    fileprivate var sizeCell = CGSize.zero
    fileprivate var sizeHeader = CGSize.zero
    fileprivate var cellSectionAttributes: [IndexPath: NSCollectionViewLayoutAttributes] = [:]
    fileprivate var headerAttribute: [NSCollectionViewLayoutAttributes] = []
    fileprivate var contentSize = CGSize.zero
    fileprivate var numberOfSection = 0
    fileprivate var itemCount: [Int: Int] = [:]
    fileprivate let paddingSection: CGFloat = 6.0
    
    //
    // MARK: - Init
    public override init() {
        super.init()
        
        self.scrollDirection = .vertical
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Override
    fileprivate func updateDataSource() {
        guard let collectionView = self.collectionView else {return}
        
        // Get section
        self.numberOfSection = collectionView.dataSource?.numberOfSections!(in: collectionView) ?? 0
        
        // Get item count for each section
        for i in 0..<self.numberOfSection {
            let count = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: i) ?? 0
            self.itemCount[i] = count
        }
        
        // Size
        let sizeScreen = collectionView.frame.size
        self.sizeCell = CGSize(width: sizeScreen.width, height: 32)
        self.sizeHeader = CGSize(width: sizeScreen.width, height: 32)
        
    }
    
    override open func prepare() {
        super.prepare()
        
        // Update data
        self.updateDataSource()
        
        // Data
        var lastY = self.paddingSection
        
        // Prepare data
        var cells: [IndexPath: NSCollectionViewLayoutAttributes] = [:]
        var headerAtts: [NSCollectionViewLayoutAttributes] = []
        
        for section in 0..<self.numberOfSection {
            
            // Header
            let headerAtt = NSCollectionViewLayoutAttributes(forSupplementaryViewOfKind: NSCollectionElementKindSectionHeader, with: IndexPath(item: 0, section: section))
            let yHeader = lastY
            headerAtt.frame = CGRect(x: 0.0, y: yHeader, width: self.sizeHeader.width, height: self.sizeHeader.height)
            headerAtts.append(headerAtt)
            
            lastY = lastY + self.sizeHeader.height
            
            // Cells
            let sectionCount = self.itemCount[section] ?? 0
            for item in 0..<sectionCount {
                
                // Frame
                let y = lastY
                
                // INdex
                let indexPath = IndexPath(item: item, section: section)
                let att = NSCollectionViewLayoutAttributes(forItemWith: indexPath)
                att.frame = CGRect(x: 0.0, y: y, width: self.sizeCell.width, height: self.sizeCell.height)
                cells[indexPath] = att
                
                // Minus
                lastY = lastY + self.sizeCell.height
            }
            
            // Padding section
            lastY = lastY + self.paddingSection
        }
        
        // Content Size
        self.contentSize = self.calculateContentSize()
        
        // Save data
        self.cellSectionAttributes = cells
        self.headerAttribute = headerAtts
    }
    
    fileprivate func calculateContentSize() -> CGSize {
        guard let collectionView = self.collectionView else {
            return CGSize.zero
        }
        
        var height =  CGFloat(self.numberOfSection) * (self.sizeHeader.height + self.paddingSection)
        
        for count in self.itemCount.values {
            height += CGFloat(count) * self.sizeCell.height
        }
        
        height = max(height, collectionView.frame.height)
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    //
    // MARK: - Override
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> NSCollectionViewLayoutAttributes? {
        return self.cellSectionAttributes[indexPath]
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [NSCollectionViewLayoutAttributes] {
        
        var cells: [NSCollectionViewLayoutAttributes] = []
        
        // Header
        for att in self.headerAttribute {
            if att.frame.intersects(rect) {
                cells.append(att)
            }
        }
        
        // Cell
        for att in self.cellSectionAttributes.values {
            if att.frame.intersects(rect) {
                cells.append(att)
            }
        }
        
        return cells
    }
    
    override open var collectionViewContentSize: CGSize {
        return self.contentSize
    }
}
