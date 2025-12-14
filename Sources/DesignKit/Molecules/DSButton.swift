//
//  WalnutButton.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 06/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// Simple healthcare button styles
public struct DSButtonStyle {
    let designKit: DesignKit
    let style: Style
    
    public enum Style {
        case primary
        case secondary
        case destructive
    }
    
    var backgroundColor: Color {
        switch style {
        case .primary: return designKit.primary
        case .secondary: return .clear
        case .destructive: return designKit.danger
        }
    }
    
    var foregroundColor: Color {
        switch style {
        case .primary, .destructive: return .white
        case .secondary: return designKit.primary
        }
    }

    var borderColor: Color? {
        switch style {
        case .primary, .destructive: return nil
        case .secondary: return designKit.primary
        }
    }
}

/// Healthcare-focused button component
public struct DSButton: View {
    private let title: String
    private let style: DSButtonStyle
    private let icon: String?
    private let action: () -> Void
    @State private var isPressed = false
    
    public init(
        _ title: String,
        style: DSButtonStyle.Style = .primary,
        icon: String? = nil,
        designKit: DesignKit,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = DSButtonStyle(designKit: designKit, style: style)
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.sm) {
                if let icon = icon {
                    Image(systemName: icon)
                        .footnote(style.designKit)
                }

                Text(title)
                    .subheadline(style.designKit)
                    .padding(.vertical, Spacing.sm)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(style.foregroundColor)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: Radius.small))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.small)
                    .stroke(style.borderColor ?? .clear, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(Animation.quick, value: isPressed)
        }
        .frame(minHeight: Spacing.tapTargetMin)
        .accessibilityLabel(title)
    }
}

/// Icon-only button
public struct HealthIconButton: View {
    private let icon: String
    private let style: DSButtonStyle
    private let action: () -> Void
    @State private var isPressed = false
    
    public init(
        icon: String,
        style: DSButtonStyle.Style = .secondary,
        designKit: DesignKit,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = DSButtonStyle(designKit: designKit, style: style)
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .footnote(style.designKit)
                .foregroundStyle(style.foregroundColor)
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)
                .background(style.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: Radius.small))
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.small)
                        .stroke(style.borderColor ?? .clear, lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.96 : 1.0)
                .animation(Animation.quick, value: isPressed)
        }
        .accessibilityLabel(icon)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { isPressing in
            isPressed = isPressing
        } perform: { }
    }
}

// MARK: - Preview

#Preview("Health Buttons") {
    let designKit = DesignKit(.default)
    return VStack(spacing: Spacing.lg) {
        VStack(spacing: Spacing.md) {
            Text("Button Styles")
                .headline(designKit)

            DSButton("Primary Action", style: .primary, designKit: designKit) { }
            DSButton("Secondary Action", style: .secondary, designKit: designKit) { }
            DSButton("Delete", style: .destructive, icon: "trash", designKit: designKit) { }
        }

        VStack(spacing: Spacing.md) {
            Text("Icon Buttons")
                .headline(designKit)

            HStack(spacing: Spacing.md) {
                HealthIconButton(icon: "heart.fill", style: .primary, designKit: designKit) { }
                HealthIconButton(icon: "plus", style: .secondary, designKit: designKit) { }
                HealthIconButton(icon: "gear", style: .secondary, designKit: designKit) { }
            }
        }
    }
    .padding(Spacing.lg)
}
