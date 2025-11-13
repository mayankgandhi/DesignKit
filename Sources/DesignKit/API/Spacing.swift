//
//  Spacing.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Flat Spacing API

public extension DesignKit {
    
    /// 4pt - Micro spacing
    static let xxs: CGFloat = 4
    
    /// 8pt - Tiny spacing
    static let xs: CGFloat = 8
    
    /// 12pt - Small spacing
    static let sm: CGFloat = 12
    
    /// 16pt - Base spacing unit
    static let md: CGFloat = 16
    
    /// 24pt - Medium-large spacing
    static let lg: CGFloat = 24
    
    /// 32pt - Large spacing
    static let xl: CGFloat = 32
    
    /// 48pt - Extra large spacing
    static let xxl: CGFloat = 48
    
    /// 64pt - Section breaks
    static let xxxl: CGFloat = 64
    
    // MARK: - Component Spacing
    
    /// Minimum tap target size (44x44)
    static let tapTargetMin: CGFloat = 44
    
    /// Preferred tap target for critical actions (56x56)
    static let tapTargetPreferred: CGFloat = 56
    
    /// Large action button height (64pt)
    static let buttonHeightLarge: CGFloat = 64
    
    /// Standard button height (48pt)
    static let buttonHeightStandard: CGFloat = 48
}
