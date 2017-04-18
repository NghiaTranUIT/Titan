//
//  FontManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

/*
 "SFUIText-Bold", "SFUIText-BoldItalic", "SFUIText-Heavy", "SFUIText-HeavyItalic", "SFUIText-Italic", "SFUIText-Light", "SFUIText-LightItalic", "SFUIText-Medium", "SFUIText-MediumItalic", "SFUIText-Regular", "SFUIText-Semibold", "SFUIText-SemiboldItalic", "SFUIText-Ultrathin", "SFUIText-UltrathinItalic"
 */

enum SFFontType {
    case bold
    case regular
    case medium
    case light
    
    var fontName: String {
        switch self {
        case .bold:
            return "SFUIText-Bold"
        case .light:
            return "SFUIText-Light"
        case .medium:
            return "SFUIText-Medium"
        case .regular:
            return "SFUIText-Regular"
        }
    }
}

class GlobalFont {
    
    //
    // MARK: - Variable
    static func font(_ type: SFFontType, size: CGFloat) -> NSFont {
        return NSFont(name: type.fontName, size: size)!
    }
    
    static func listAllAvailableFonts() {
        Logger.info(NSFontManager.shared().availableFonts)
    }
}
