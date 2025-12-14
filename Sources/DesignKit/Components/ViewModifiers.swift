//
//  ViewModifiers.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - View Modifiers

public struct StatusBadge: ViewModifier {
    
    let color: Color
    let designKit: DesignKit
    
    public init(color: Color, designKit: DesignKit) {
        self.color = color
        self.designKit = designKit
    }
    
    public func body(content: Content) -> some View {
        content
            .buttonText(designKit)
            .textCase(.uppercase)
            .foregroundStyle(designKit.absoluteWhite)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xxs)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: Radius.tight))
    }
}

public struct Card: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let designKit: DesignKit
    
    public init(designKit: DesignKit) {
        self.designKit = designKit
    }
    
    public func body(content: Content) -> some View {
        content
            .background(designKit.surface(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: Radius.large))
            .shadow(
                color: Shadow.subtle.color,
                radius: Shadow.subtle.radius,
                x: Shadow.subtle.x,
                y: Shadow.subtle.y
            )
    }
}

// MARK: - View Extensions

public extension View {
    
    /// Apply status badge style
    func statusBadge(color: Color, designKit: DesignKit) -> some View {
        modifier(StatusBadge(color: color, designKit: designKit))
    }
    
    /// Apply card style
    func card(designKit: DesignKit) -> some View {
        modifier(Card(designKit: designKit))
    }
}
