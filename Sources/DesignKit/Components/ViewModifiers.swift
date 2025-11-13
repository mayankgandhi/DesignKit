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
    
    public init(color: Color) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .buttonText()
            .textCase(.uppercase)
            .foregroundStyle(DesignKit.absoluteWhite)
            .padding(.horizontal, DesignKit.sm)
            .padding(.vertical, DesignKit.xxs)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusTight))
    }
}

public struct Card: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    public func body(content: Content) -> some View {
        content
            .background(DesignKit.surface(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.large))
            .shadow(
                color: DesignKit.shadowSubtle.color,
                radius: DesignKit.shadowSubtle.radius,
                x: DesignKit.shadowSubtle.x,
                y: DesignKit.shadowSubtle.y
            )
    }
}

// MARK: - View Extensions

public extension View {
    
    /// Apply status badge style
    func statusBadge(color: Color) -> some View {
        modifier(StatusBadge(color: color))
    }
    
    /// Apply card style
    func card() -> some View {
        modifier(Card())
    }
}
