//
//  Animations.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Flat Animation API

public extension DesignKit {
    
    /// Instant feedback (0.1s) - for critical actions
    static let animationInstant = Animation.easeOut(duration: 0.1)
    
    /// Quick response (0.2s) - for UI feedback
    static let animationQuick = Animation.easeInOut(duration: 0.2)
    
    /// Standard (0.3s) - for transitions
    static let animationStandard = Animation.easeInOut(duration: 0.3)
    
    /// Urgent pulse - for active alarms
    static let animationPulse = Animation
        .easeInOut(duration: 1.0)
        .repeatForever(autoreverses: true)
    
    /// Spring - for tactile feedback
    static let animationSpring = Animation.spring(response: 0.3, dampingFraction: 0.7)
}
