//
//  Spacing.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Spacing Tokens

/// Spacing constants for consistent layout throughout the design system
public enum Spacing {

    /// 4pt - Micro spacing
    public static let xxs: CGFloat = 4

    /// 8pt - Tiny spacing
    public static let xs: CGFloat = 8

    /// 12pt - Small spacing
    public static let sm: CGFloat = 12

    /// 16pt - Base spacing unit
    public static let md: CGFloat = 16

    /// 24pt - Medium-large spacing
    public static let lg: CGFloat = 24

    /// 32pt - Large spacing
    public static let xl: CGFloat = 32

    /// 48pt - Extra large spacing
    public static let xxl: CGFloat = 48

    /// 64pt - Section breaks
    public static let xxxl: CGFloat = 64

    // MARK: - Component Spacing

    /// Minimum tap target size (44x44)
    public static let tapTargetMin: CGFloat = 44

    /// Preferred tap target for critical actions (56x56)
    public static let tapTargetPreferred: CGFloat = 56

    /// Large action button height (64pt)
    public static let buttonHeightLarge: CGFloat = 64

    /// Standard button height (48pt)
    public static let buttonHeightStandard: CGFloat = 48
}
