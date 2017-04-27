//
//  Button.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/27/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - HoverButton
open class HoverButton: NSButton {
    
    //
    // MARK: - Variable
    fileprivate var trackingArea: NSTrackingArea?
    override open var state: Int {
        didSet {
            Logger.info("State change = \(self.state)")
        }
    }
    
    //
    // MARK: - Init    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupTrackingArea()
        self.updateColorAnimator(false)
    }
    
    //
    // MARK: - Public
    fileprivate func setupTrackingArea() {
        if self.trackingArea == nil {
            self.trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
            self.addTrackingArea(self.trackingArea!)
        }
    }
    
    open override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        self.updateColorAnimator(true)
    }
    
    open override func mouseExited(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        self.updateColorAnimator(false)
    }
    
    fileprivate func updateColorAnimator(_ isEntered: Bool) {
        let color = isEntered ? NSColor.white : NSColor(hexString: "#d6cce2")
        self.setTextColor(color)
    }
    
    //
    // MARK: - Color
    fileprivate func setTextColor(_ color: NSColor) {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributes =
            [NSForegroundColorAttributeName: color,
             NSFontAttributeName: self.font!,
             NSParagraphStyleAttributeName: style
                ] as [String : Any]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.attributedTitle = attributedTitle
    }
}
