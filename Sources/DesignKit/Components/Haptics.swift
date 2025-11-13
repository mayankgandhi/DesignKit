//
//  Haptics.swift
//  DesignKit
//
//  Created on 2025.
//

import UIKit

// MARK: - Haptic Feedback

public enum DesignKitHaptics {
    
    public static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    public static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    public static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    // MARK: - Contextual Haptics
    
    /// Heavy impact for critical actions (setting alarm)
    public static func criticalAction() {
        impact(.heavy)
    }
    
    /// Medium impact for standard interactions
    public static func standardAction() {
        impact(.medium)
    }
    
    /// Success haptic for alarm confirmation
    public static func success() {
        notification(.success)
    }
    
    /// Warning haptic for alarm about to trigger
    public static func warning() {
        notification(.warning)
    }
    
    /// Error haptic for failed actions
    public static func error() {
        notification(.error)
    }
}
