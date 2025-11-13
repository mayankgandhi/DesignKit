//
//  ButtonStyles.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Button Styles

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) var isEnabled
    let isDestructive: Bool
    
    public init(isDestructive: Bool = false) {
        self.isDestructive = isDestructive
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .subheadline()
            .foregroundStyle(DesignKit.absoluteWhite)
            .frame(maxWidth: .infinity)
            .frame(height: DesignKit.buttonHeightLarge)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusMedium))
            .shadow(
                color: DesignKit.shadowCritical.color,
                radius: DesignKit.shadowCritical.radius,
                x: DesignKit.shadowCritical.x,
                y: DesignKit.shadowCritical.y
            )
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(DesignKit.animationQuick, value: configuration.isPressed)
    }
    
    private var backgroundColor: Color {
        if !isEnabled {
            return DesignKit.disabled
        }
        return isDestructive ? DesignKit.danger : DesignKit.primary
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .subheadline()
            .foregroundStyle(isEnabled ? DesignKit.textPrimary(for: colorScheme) : DesignKit.disabled)
            .frame(maxWidth: .infinity)
            .frame(height: DesignKit.buttonHeightStandard)
            .background(DesignKit.surface(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusMedium))
            .overlay(
                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .strokeBorder(
                        isEnabled ? DesignKit.textTertiary(for: colorScheme) : DesignKit.disabled,
                        lineWidth: 2
                    )
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(DesignKit.animationQuick, value: configuration.isPressed)
    }
}

public struct TertiaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .subheadline()
            .foregroundStyle(isEnabled ? DesignKit.textPrimary(for: colorScheme) : DesignKit.disabled)
            .padding(.horizontal, DesignKit.md)
            .padding(.vertical, DesignKit.sm)
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(DesignKit.animationQuick, value: configuration.isPressed)
    }
}

// MARK: - Button Extensions

public extension Button {
    
    /// Apply primary button style with optional destructive variant
    func primaryButton(isDestructive: Bool = false) -> some View {
        self.buttonStyle(PrimaryButtonStyle(isDestructive: isDestructive))
    }
    
    /// Apply secondary button style
    func secondaryButton() -> some View {
        self.buttonStyle(SecondaryButtonStyle())
    }
    
    /// Apply tertiary button style (text-only button)
    func tertiaryButton() -> some View {
        self.buttonStyle(TertiaryButtonStyle())
    }
}
