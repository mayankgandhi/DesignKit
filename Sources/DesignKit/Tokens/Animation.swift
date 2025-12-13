//
//  Animation.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Animation Tokens

/// Animation constants for consistent motion throughout the design system
public enum Animation {

    /// Instant feedback (0.1s) - for critical actions
    public static let instant = SwiftUI.Animation.easeOut(duration: 0.1)

    /// Quick response (0.2s) - for UI feedback
    public static let quick = SwiftUI.Animation.easeInOut(duration: 0.2)

    /// Standard (0.3s) - for transitions
    public static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)

    /// Urgent pulse - for active alarms
    public static let pulse = SwiftUI.Animation
        .easeInOut(duration: 1.0)
        .repeatForever(autoreverses: true)

    /// Spring - for tactile feedback
    public static let spring = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7)
}
