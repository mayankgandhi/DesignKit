//
//  Shadow.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Shadow Style

/// Shadow configuration
public struct ShadowStyle {
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

// MARK: - Shadow Tokens

/// Shadow constants for consistent depth throughout the design system
public enum Shadow {

    /// Sharp, high-contrast shadow for critical elements
    public static let critical = ShadowStyle(
        color: Color.black.opacity(0.3),
        radius: 8,
        x: 0,
        y: 4
    )

    /// Elevated surface shadow
    public static let elevated = ShadowStyle(
        color: Color.black.opacity(0.15),
        radius: 12,
        x: 0,
        y: 6
    )

    /// Subtle depth
    public static let subtle = ShadowStyle(
        color: Color.black.opacity(0.08),
        radius: 4,
        x: 0,
        y: 2
    )
}
