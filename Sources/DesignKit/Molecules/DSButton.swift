//
//  WalnutButton.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 06/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// Simple healthcare button styles
public enum DSButtonStyle {
    case primary
    case secondary
    case destructive
    
    var backgroundColor: Color {
        switch self {
        case .primary: return DesignKit.primary
        case .secondary: return .clear
        case .destructive: return DesignKit.danger
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary, .destructive: return .white
        case .secondary: return DesignKit.primary
        }
    }

    var borderColor: Color? {
        switch self {
        case .primary, .destructive: return nil
        case .secondary: return DesignKit.primary
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
        style: DSButtonStyle = .primary,
        icon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: DesignKit.sm) {
                if let icon = icon {
                    Image(systemName: icon)
                        .footnote()
                }

                Text(title)
                    .subheadline()
                    .padding(.vertical, DesignKit.sm)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(style.foregroundColor)
            .padding(.horizontal, DesignKit.md)
            .padding(.vertical, DesignKit.sm)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusSmall))
            .overlay(
                RoundedRectangle(cornerRadius: DesignKit.radiusSmall)
                    .stroke(style.borderColor ?? .clear, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(DesignKit.animationQuick, value: isPressed)
        }
        .frame(minHeight: DesignKit.tapTargetMin)
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
        style: DSButtonStyle = .secondary,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .footnote()
                .foregroundStyle(style.foregroundColor)
                .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)
                .background(style.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusSmall))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignKit.radiusSmall)
                        .stroke(style.borderColor ?? .clear, lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.96 : 1.0)
                .animation(DesignKit.animationQuick, value: isPressed)
        }
        .accessibilityLabel(icon)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { isPressing in
            isPressed = isPressing
        } perform: { }
    }
}

// MARK: - Preview

#Preview("Health Buttons") {
    VStack(spacing: DesignKit.lg) {
        VStack(spacing: DesignKit.md) {
            Text("Button Styles")
                .font(.headline)

            DSButton("Primary Action", style: .primary) { }
            DSButton("Secondary Action", style: .secondary) { }
            DSButton("Delete", style: .destructive, icon: "trash") { }
        }

        VStack(spacing: DesignKit.md) {
            Text("Icon Buttons")
                .font(.headline)

            HStack(spacing: DesignKit.md) {
                HealthIconButton(icon: "heart.fill", style: .primary) { }
                HealthIconButton(icon: "plus", style: .secondary) { }
                HealthIconButton(icon: "gear", style: .secondary) { }
            }
        }
    }
    .padding(DesignKit.lg)
}
