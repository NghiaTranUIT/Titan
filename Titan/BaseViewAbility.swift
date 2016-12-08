//
//  BaseViewAbility.swift
//  Titan
//
//  Created by Nghia Tran on 12/8/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation


//
// MARK: - BaseViewAbility
/// I don't prefer to way to subclass BaseClass
/// So BaseViewAbility will contain all things BaseClass does, but it's flexible 
/// We don't need create BaseView, BaseCollectionViewCell, Base .....
/// Just conform this protocol
protocol BaseViewAbility {
    
    
    /// Init Common
    /// Intent to do everything common here
    /// func initCommon() will call after awakeFromNib()
    func initCommon()
    
    
    /// Appearance
    /// To do all things about UIs
    func initAppearance()
}



