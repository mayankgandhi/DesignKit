//
//  Colors.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Flat Color API

public extension DesignKit {
    
    // MARK: - Base Colors
    
    var absoluteBlack: Color {
        configuration.colors.absoluteBlack
    }
    
    var absoluteWhite: Color {
        configuration.colors.absoluteWhite
    }
    
    var surfaceDark: Color {
        configuration.colors.surfaceDark
    }
    
    var surfaceLight: Color {
        configuration.colors.surfaceLight
    }
    
    // MARK: - Primary Brand Colors
    
    var primary: Color {
        configuration.colors.primary
    }
    
    var primaryDark: Color {
        configuration.colors.primaryDark
    }
    
    var accent: Color {
        configuration.colors.accent
    }
    
    // MARK: - Semantic Actions
    
    var success: Color {
        configuration.colors.success
    }
    
    var warning: Color {
        configuration.colors.warning
    }
    
    var danger: Color {
        configuration.colors.danger
    }
    
    // MARK: - Alarm States
    
    var scheduled: Color {
        configuration.colors.scheduled
    }
    
    var running: Color {
        configuration.colors.running
    }
    
    var paused: Color {
        configuration.colors.paused
    }
    
    var alerting: Color {
        configuration.colors.alerting
    }
    
    var disabled: Color {
        configuration.colors.disabled
    }
    
    // MARK: - Text Hierarchy
    
    /// Primary text - maximum contrast
    func textPrimary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? absoluteWhite : absoluteBlack
    }
    
    /// Secondary text - 70% opacity for hierarchy
    func textSecondary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.7)
            : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.7)
    }
    
    /// Tertiary text - 50% opacity for subtle info
    func textTertiary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.5)
            : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5)
    }
    
    // MARK: - Background System
    
    func background(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? absoluteBlack : absoluteWhite
    }
    
    func surface(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? surfaceDark : surfaceLight
    }
    
    // MARK: - Liquid Glass Background Gradient
    
    func liquidGlassGradient(for colorScheme: ColorScheme) -> some View {
        if colorScheme == .dark {
            return ZStack {
                // Base gradient - Soft neutral dark with subtle warm undertones
                LinearGradient(
                    colors: [
                        Color(red: 0.04, green: 0.04, blue: 0.04),  // Soft charcoal
                        Color(red: 0.05, green: 0.05, blue: 0.05),  // Neutral dark gray
                        Color(red: 0.06, green: 0.06, blue: 0.05),  // Barely warm gray
                        Color(red: 0.05, green: 0.04, blue: 0.04),  // Subtle warm undertone
                        Color(red: 0.04, green: 0.04, blue: 0.04)   // Return to neutral
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Mid-layer gradient - Very subtle diagonal accent
                LinearGradient(
                    colors: [
                        Color.clear,
                        primary.opacity(0.04),
                        Color.clear,
                        accent.opacity(0.03),
                        Color.clear
                    ],
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
                
                // Radial depth overlay - Gentle center glow
                RadialGradient(
                    colors: [
                        primary.opacity(0.02),
                        Color.clear,
                        Color.clear
                    ],
                    center: .center,
                    startRadius: 50,
                    endRadius: 400
                )
                
                // Top shimmer - Delicate light reflection
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.03),
                        Color.white.opacity(0.01),
                        Color.clear,
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                )
                
                // Bottom glow - Barely-there depth
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.clear,
                        primary.opacity(0.03),
                        primaryDark.opacity(0.02)
                    ],
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
        } else {
            return ZStack {
                // Base gradient - Soft warm whites with peachy/amber tints
                LinearGradient(
                    colors: [
                        Color(red: 0.99, green: 0.96, blue: 0.93),  // Warm cream
                        Color(red: 0.99, green: 0.95, blue: 0.91),  // Soft peach-white
                        Color(red: 0.99, green: 0.97, blue: 0.94),  // Ivory glow
                        Color(red: 0.98, green: 0.96, blue: 0.93),  // Champagne-white
                        Color(red: 0.99, green: 0.96, blue: 0.92)   // Vanilla-white
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Mid-layer gradient - Diagonal warm wash
                LinearGradient(
                    colors: [
                        Color.clear,
                        primary.opacity(0.06),
                        Color.clear,
                        accent.opacity(0.04),
                        Color.clear
                    ],
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
                
                // Radial depth overlay - Subtle center highlight
                RadialGradient(
                    colors: [
                        Color.white.opacity(0.4),
                        Color.clear,
                        Color.clear
                    ],
                    center: .center,
                    startRadius: 100,
                    endRadius: 500
                )
                
                // Top luminance - Bright edge
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.1),
                        Color.clear,
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                )
                
                // Bottom color tint - Subtle warm depth
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.clear,
                        primary.opacity(0.04),
                        accent.opacity(0.03)
                    ],
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
        }
    }
}
