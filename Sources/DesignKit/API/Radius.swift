//
//  Radius.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Flat Radius API

public extension DesignKit {
    
    /// 0pt - Sharp corners for urgency
    static let radiusNone: CGFloat = 0
    
    /// 4pt - Tight radius
    static let radiusTight: CGFloat = 4
    
    /// 8pt - Small radius
    static let radiusSmall: CGFloat = 8
    
    /// 12pt - Medium radius
    static let radiusMedium: CGFloat = 12
    
    /// 16pt - Large radius
    static let radiusLarge: CGFloat = 16

    /// 16pt - Large radius
    /// - Warning: Deprecated. Use `radiusLarge` instead for consistency with other radius constants.
    @available(*, deprecated, renamed: "radiusLarge")
    static let large: CGFloat = 16
    
    /// 24pt - Extra large radius
    static let radiusXLarge: CGFloat = 24
    
    /// Full circle
    static let radiusFull: CGFloat = 999
}
