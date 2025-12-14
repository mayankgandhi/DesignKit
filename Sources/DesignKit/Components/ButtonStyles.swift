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
    let designKit: DesignKit
    
    public init(isDestructive: Bool = false, designKit: DesignKit) {
        self.isDestructive = isDestructive
        self.designKit = designKit
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .subheadline(designKit)
            .foregroundStyle(designKit.absoluteWhite)
            .frame(maxWidth: .infinity)
            .frame(height: Spacing.buttonHeightLarge)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: Radius.medium))
            .shadow(
                color: Shadow.critical.color,
                radius: Shadow.critical.radius,
                x: Shadow.critical.x,
                y: Shadow.critical.y
            )
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(Animation.quick, value: configuration.isPressed)
    }
    
    private var backgroundColor: Color {
        if !isEnabled {
            return designKit.disabled
        }
        return isDestructive ? designKit.danger : designKit.primary
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) var isEnabled
    let designKit: DesignKit
    
    public init(designKit: DesignKit) {
        self.designKit = designKit
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .subheadline(designKit)
            .foregroundStyle(isEnabled ? designKit.textPrimary(for: colorScheme) : designKit.disabled)
            .frame(maxWidth: .infinity)
            .frame(height: Spacing.buttonHeightStandard)
            .background(designKit.surface(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: Radius.medium))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.medium)
                    .strokeBorder(
                        isEnabled ? designKit.textTertiary(for: colorScheme) : designKit.disabled,
                        lineWidth: 2
                    )
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(Animation.quick, value: configuration.isPressed)
    }
}

public struct TertiaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) var isEnabled
    let designKit: DesignKit
    
    public init(designKit: DesignKit) {
        self.designKit = designKit
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .subheadline(designKit)
            .foregroundStyle(isEnabled ? designKit.textPrimary(for: colorScheme) : designKit.disabled)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(Animation.quick, value: configuration.isPressed)
    }
}

// MARK: - Button Extensions

public extension Button {
    
    /// Apply primary button style with optional destructive variant
    func primaryButton(isDestructive: Bool = false, designKit: DesignKit) -> some View {
        self.buttonStyle(PrimaryButtonStyle(isDestructive: isDestructive, designKit: designKit))
    }
    
    /// Apply secondary button style
    func secondaryButton(designKit: DesignKit) -> some View {
        self.buttonStyle(SecondaryButtonStyle(designKit: designKit))
    }
    
    /// Apply tertiary button style (text-only button)
    func tertiaryButton(designKit: DesignKit) -> some View {
        self.buttonStyle(TertiaryButtonStyle(designKit: designKit))
    }
}
