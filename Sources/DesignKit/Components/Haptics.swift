//
//  Haptics.swift
//  DesignKit
//
//  Created on 2025.
//

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Haptic Feedback

public enum DesignKitHaptics {

    #if canImport(UIKit)
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
    #else
    // No-op implementations for non-iOS platforms
    public static func impact(_ style: Int) {}
    public static func notification(_ type: Int) {}
    public static func selection() {}
    #endif

    // MARK: - Contextual Haptics

    /// Heavy impact for critical actions (setting alarm)
    public static func criticalAction() {
        #if canImport(UIKit)
        impact(.heavy)
        #endif
    }

    /// Medium impact for standard interactions
    public static func standardAction() {
        #if canImport(UIKit)
        impact(.medium)
        #endif
    }

    /// Success haptic for alarm confirmation
    public static func success() {
        #if canImport(UIKit)
        notification(.success)
        #endif
    }

    /// Warning haptic for alarm about to trigger
    public static func warning() {
        #if canImport(UIKit)
        notification(.warning)
        #endif
    }

    /// Error haptic for failed actions
    public static func error() {
        #if canImport(UIKit)
        notification(.error)
        #endif
    }
}
