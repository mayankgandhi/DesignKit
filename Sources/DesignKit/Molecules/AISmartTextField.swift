//
//  AISmartTextField.swift
//  DesignKit
//
//  Created by Mayank Gandhi on 13/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// AI-assisted text field component with intelligent text generation
/// Features a sparkle button that opens a bottom sheet for AI-powered suggestions
public struct AISmartTextField: View {
    // MARK: - Bindings
    @Binding private var text: String

    // MARK: - State
    @State private var isShowingAISheet: Bool = false
    @State private var isPressed: Bool = false
    @FocusState private var isFocused: Bool

    // MARK: - Configuration
    private let placeholder: String
    private let axis: Axis
    private let service: AIGenerationService
    private let helperText: String?
    private let icon: String?
    private let iconColor: Color
    private let designKit: DesignKit

    // MARK: - Initialization
    public init(
        text: Binding<String>,
        placeholder: String = "Enter text...",
        axis: Axis = .horizontal,
        service: AIGenerationService = MockAIGenerationService(),
        helperText: String? = nil,
        icon: String? = nil,
        iconColor: Color? = nil,
        designKit: DesignKit
    ) {
        self._text = text
        self.placeholder = placeholder
        self.axis = axis
        self.service = service
        self.helperText = helperText
        self.icon = icon
        self.iconColor = iconColor ?? designKit.primary
        self.designKit = designKit
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            // Main text field container
            HStack(spacing: Spacing.md) {
                // Optional icon
                if let icon = icon {
                    iconView(icon: icon)
                }

                // Text field
                textFieldView

                // AI sparkle button
                sparkleButton
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, axis == .vertical ? Spacing.md : Spacing.sm + 2)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: Radius.medium))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.medium)
                    .stroke(strokeColor, lineWidth: isFocused ? 2 : 1)
            )
            .scaleEffect(isPressed ? 0.99 : 1.0)
            .animation(Animation.quick, value: isPressed)
            .animation(Animation.standard, value: isFocused)
            .shadow(
                color: isFocused ? Shadow.elevated.color : Shadow.subtle.color,
                radius: isFocused ? Shadow.elevated.radius : Shadow.subtle.radius,
                x: isFocused ? Shadow.elevated.x : Shadow.subtle.x,
                y: isFocused ? Shadow.elevated.y : Shadow.subtle.y
            )
            .onTapGesture {
                isFocused = true
            }
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                isPressed = pressing
            })

            // Helper text
            if let helper = helperText, !helper.isEmpty {
                Text(helper)
                    .caption(designKit)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, Spacing.md)
            }
        }
        .sheet(isPresented: $isShowingAISheet) {
            AIGeneratorSheet(
                isPresented: $isShowingAISheet,
                fieldName: placeholder,
                service: service,
                designKit: designKit,
                onSelectSuggestion: { selectedText in
                    text = selectedText
                }
            )
        }
    }

    // MARK: - Icon View
    private func iconView(icon: String) -> some View {
        ZStack {
            // Gradient background
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            (isFocused ? .gray.opacity(0.4) : iconColor).opacity(0.08),
                            (isFocused ? .gray.opacity(0.4) : iconColor).opacity(0.12)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

            // Subtle ring
            Circle()
                .stroke((isFocused ? .gray.opacity(0.5) : iconColor).opacity(0.12), lineWidth: 1)
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

            // Icon
            Image(systemName: icon)
                .tickerTitle(designKit)
                .foregroundStyle(
                    isFocused ? Color(.systemGray) : iconColor.opacity(0.8)
                )
        }
        .scaleEffect(isFocused ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }

    // MARK: - Text Field View
    private var textFieldView: some View {
        Group {
            if axis == .horizontal {
                TextField(placeholder, text: $text)
                    .body(designKit)
                    .foregroundStyle(.primary)
                    .focused($isFocused)
            } else {
                TextField(placeholder, text: $text, axis: .vertical)
                    .body(designKit)
                    .foregroundStyle(.primary)
                    .focused($isFocused)
                    .lineLimit(3...6)
            }
        }
    }

    // MARK: - Sparkle Button
    private var sparkleButton: some View {
        Button {
            isShowingAISheet = true
        } label: {
            ZStack {
                // Background with ultraThinMaterial
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

                // Gradient icon
                Image(systemName: "sparkles")
                    .tickerTitle(designKit)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.36, green: 0.36, blue: 1.0),    // Indigo
                                Color(red: 0.61, green: 0.35, blue: 0.71),   // Purple
                                Color(red: 0.0, green: 0.48, blue: 1.0)      // Blue
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .shadow(
                color: Color(red: 0.36, green: 0.36, blue: 1.0).opacity(0.3),
                radius: Shadow.elevated.radius,
                x: 0,
                y: Shadow.elevated.y
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Generate with AI")
        .accessibilityHint("Opens AI assistant to generate text suggestions")
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Background View
    private var backgroundView: some View {
        Group {
            if isFocused {
                RoundedRectangle(cornerRadius: Radius.medium)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium)
                            .fill(.gray.opacity(0.7).opacity(0.3))
                    )
            } else {
                RoundedRectangle(cornerRadius: Radius.medium)
                    .fill(isPressed ? .gray.opacity(0.7) : .white.opacity(0.95))
            }
        }
    }

    // MARK: - Stroke Color
    private var strokeColor: Color {
        if isFocused {
            return .gray.opacity(0.4).opacity(0.8)
        } else {
            return .gray.opacity(0.6)
        }
    }
}

// MARK: - Convenience Initializers
public extension AISmartTextField {
    /// Simple initializer with just text binding
    init(text: Binding<String>, designKit: DesignKit) {
        self.init(text: text, placeholder: "Enter text...", designKit: designKit)
    }

    /// Initializer with custom placeholder
    init(text: Binding<String>, placeholder: String, designKit: DesignKit) {
        self.init(text: text, placeholder: placeholder, axis: .horizontal, designKit: designKit)
    }
}

// MARK: - Previews
#Preview("Basic States") {
    let designKit = DesignKit(.default)
    return VStack(spacing: Spacing.lg) {
        Text("AI Smart Text Field Examples")
            .title2(designKit)

        // Empty state
        AISmartTextField(
            text: .constant(""),
            placeholder: "Product name",
            designKit: designKit
        )

        // Filled state
        AISmartTextField(
            text: .constant("Organic Green Tea"),
            placeholder: "Product name",
            designKit: designKit
        )

        // With icon
        AISmartTextField(
            text: .constant(""),
            placeholder: "Product description",
            icon: "text.alignleft",
            iconColor: .blue,
            designKit: designKit
        )

        // Multi-line
        AISmartTextField(
            text: .constant("This is a longer description that spans multiple lines and demonstrates the vertical axis functionality."),
            placeholder: "Description",
            axis: .vertical,
            designKit: designKit
        )

        // With helper text
        AISmartTextField(
            text: .constant(""),
            placeholder: "Enter product name",
            helperText: "Tap the sparkle button to generate suggestions with AI",
            designKit: designKit
        )

        Spacer()
    }
    .padding()
    .background(.gray.opacity(0.1))
}

#Preview("Dark Mode") {
    let designKit = DesignKit(.default)
    return VStack(spacing: Spacing.lg) {
        AISmartTextField(
            text: .constant("Premium Coffee Beans"),
            placeholder: "Product name",
            icon: "cup.and.saucer.fill",
            iconColor: .brown,
            designKit: designKit
        )

        AISmartTextField(
            text: .constant(""),
            placeholder: "Enter description",
            axis: .vertical,
            helperText: "Use AI to generate compelling product descriptions",
            designKit: designKit
        )

        Spacer()
    }
    .padding()
    .background(.gray.opacity(0.1))
    .preferredColorScheme(.dark)
}
