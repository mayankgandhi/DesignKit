//
//  Shadows.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Shadow Types

public struct Shadow {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat
    
    public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

// MARK: - Flat Shadow API

public extension DesignKit {
    
    /// Sharp, high-contrast shadow for critical elements
    static let shadowCritical = Shadow(
        color: Color.black.opacity(0.3),
        radius: 8,
        x: 0,
        y: 4
    )
    
    /// Elevated surface shadow
    static let shadowElevated = Shadow(
        color: Color.black.opacity(0.15),
        radius: 12,
        x: 0,
        y: 6
    )
    
    /// Subtle depth
    static let shadowSubtle = Shadow(
        color: Color.black.opacity(0.08),
        radius: 4,
        x: 0,
        y: 2
    )
}
