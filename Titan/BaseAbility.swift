//
//  BaseViewAbility.swift
//  Titan
//
//  Created by Nghia Tran on 12/8/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation


//
// MARK: - BaseAbility
/// I don't prefer to way to subclass BaseClass
/// So BaseAbility will contain all things BaseClass does, but it's flexible
/// We don't need create BaseView, BaseCollectionViewCell, Base .....
/// Just conform this protocol
protocol BaseAbility {
    
    
    /// Init Common
    /// Intent to do everything common here
    /// func initCommon() will call after awakeFromNib() if it's from NSView
    /// Or call from ViewDidLoad if it's Controller
    func initCommon()
    
    
    /// Appearance
    /// To do all things about UIs
    func initAppearance()
    
    
    func initBinding()
    
    func initActions()
}



