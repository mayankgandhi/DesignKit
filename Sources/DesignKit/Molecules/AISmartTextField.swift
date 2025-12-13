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

    // MARK: - Initialization
    public init(
        text: Binding<String>,
        placeholder: String = "Enter text...",
        axis: Axis = .horizontal,
        service: AIGenerationService = MockAIGenerationService(),
        helperText: String? = nil,
        icon: String? = nil,
        iconColor: Color = DesignKit.primary
    ) {
        self._text = text
        self.placeholder = placeholder
        self.axis = axis
        self.service = service
        self.helperText = helperText
        self.icon = icon
        self.iconColor = iconColor
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: DesignKit.xs) {
            // Main text field container
            HStack(spacing: DesignKit.md) {
                // Optional icon
                if let icon = icon {
                    iconView(icon: icon)
                }

                // Text field
                textFieldView

                // AI sparkle button
                sparkleButton
            }
            .padding(.horizontal, DesignKit.md)
            .padding(.vertical, axis == .vertical ? DesignKit.md : DesignKit.sm + 2)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusMedium))
            .overlay(
                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .stroke(strokeColor, lineWidth: isFocused ? 2 : 1)
            )
            .scaleEffect(isPressed ? 0.99 : 1.0)
            .animation(DesignKit.animationQuick, value: isPressed)
            .animation(DesignKit.animationStandard, value: isFocused)
            .shadow(
                color: isFocused ? DesignKit.shadowElevated.color : DesignKit.shadowSubtle.color,
                radius: isFocused ? DesignKit.shadowElevated.radius : DesignKit.shadowSubtle.radius,
                x: isFocused ? DesignKit.shadowElevated.x : DesignKit.shadowSubtle.x,
                y: isFocused ? DesignKit.shadowElevated.y : DesignKit.shadowSubtle.y
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
                    .caption()
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, DesignKit.md)
            }
        }
        .sheet(isPresented: $isShowingAISheet) {
            AIGeneratorSheet(
                isPresented: $isShowingAISheet,
                fieldName: placeholder,
                service: service,
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
                            (isFocused ? Color(.systemGray3) : iconColor).opacity(0.08),
                            (isFocused ? Color(.systemGray3) : iconColor).opacity(0.12)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)

            // Subtle ring
            Circle()
                .stroke((isFocused ? Color(.systemGray4) : iconColor).opacity(0.12), lineWidth: 1)
                .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)

            // Icon
            Image(systemName: icon)
                .tickerTitle()
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
                    .body()
                    .foregroundStyle(.primary)
                    .focused($isFocused)
            } else {
                TextField(placeholder, text: $text, axis: .vertical)
                    .body()
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
                    .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)

                // Gradient icon
                Image(systemName: "sparkles")
                    .tickerTitle()
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
                radius: DesignKit.shadowElevated.radius,
                x: 0,
                y: DesignKit.shadowElevated.y
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
                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                            .fill(Color(.systemGray6).opacity(0.3))
                    )
            } else {
                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .fill(isPressed ? Color(.systemGray6) : Color(.systemBackground))
            }
        }
    }

    // MARK: - Stroke Color
    private var strokeColor: Color {
        if isFocused {
            return Color(.systemGray3).opacity(0.8)
        } else {
            return Color(.systemGray5)
        }
    }
}

// MARK: - Convenience Initializers
public extension AISmartTextField {
    /// Simple initializer with just text binding
    init(text: Binding<String>) {
        self.init(text: text, placeholder: "Enter text...")
    }

    /// Initializer with custom placeholder
    init(text: Binding<String>, placeholder: String) {
        self.init(text: text, placeholder: placeholder, axis: .horizontal)
    }
}

// MARK: - Previews
#Preview("Basic States") {
    VStack(spacing: DesignKit.lg) {
        Text("AI Smart Text Field Examples")
            .title2()

        // Empty state
        AISmartTextField(
            text: .constant(""),
            placeholder: "Product name"
        )

        // Filled state
        AISmartTextField(
            text: .constant("Organic Green Tea"),
            placeholder: "Product name"
        )

        // With icon
        AISmartTextField(
            text: .constant(""),
            placeholder: "Product description",
            icon: "text.alignleft",
            iconColor: .blue
        )

        // Multi-line
        AISmartTextField(
            text: .constant("This is a longer description that spans multiple lines and demonstrates the vertical axis functionality."),
            placeholder: "Description",
            axis: .vertical
        )

        // With helper text
        AISmartTextField(
            text: .constant(""),
            placeholder: "Enter product name",
            helperText: "Tap the sparkle button to generate suggestions with AI"
        )

        Spacer()
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Dark Mode") {
    VStack(spacing: DesignKit.lg) {
        AISmartTextField(
            text: .constant("Premium Coffee Beans"),
            placeholder: "Product name",
            icon: "cup.and.saucer.fill",
            iconColor: .brown
        )

        AISmartTextField(
            text: .constant(""),
            placeholder: "Enter description",
            axis: .vertical,
            helperText: "Use AI to generate compelling product descriptions"
        )

        Spacer()
    }
    .padding()
    .background(Color(.systemGroupedBackground))
    .preferredColorScheme(.dark)
}
