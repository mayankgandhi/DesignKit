//
//  Radius.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Radius Tokens

/// Corner radius constants for consistent shapes throughout the design system
public enum Radius {

    /// 0pt - Sharp corners for urgency
    public static let none: CGFloat = 0

    /// 4pt - Tight radius
    public static let tight: CGFloat = 4

    /// 8pt - Small radius
    public static let small: CGFloat = 8

    /// 12pt - Medium radius
    public static let medium: CGFloat = 12

    /// 16pt - Large radius
    public static let large: CGFloat = 16

    /// 24pt - Extra large radius
    public static let xlarge: CGFloat = 24

    /// Full circle
    public static let full: CGFloat = 999
}
