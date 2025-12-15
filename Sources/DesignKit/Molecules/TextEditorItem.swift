//
//  TextEditorItem.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 15/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Multi-line text editor component with MenuListItem-inspired design
public struct TextEditorItem: View {
    private let icon: String?
    private let title: String
    private let placeholder: String
    private let helperText: String?
    private let errorMessage: String?
    private let iconColor: Color
    private let isRequired: Bool
    private let characterLimit: Int?
    private let minLineHeight: Int
    private let maxLineHeight: Int
    private let designKit: DesignKit
    #if os(iOS)
    private let keyboardType: UIKeyboardType
    private let contentType: UITextContentType?
    #endif

    @Binding private var text: String
    @FocusState private var isFocused: Bool
    @State private var isPressed = false

    private var validationState: ValidationState {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error
        } else if isOverLimit {
            return .error
        } else if isRequired && text.isEmpty {
            return .warning
        } else if !text.isEmpty {
            return .success
        } else {
            return .normal
        }
    }

    private var isOverLimit: Bool {
        guard let limit = characterLimit else { return false }
        return text.count > limit
    }

    private var calculatedMinHeight: CGFloat {
        CGFloat(minLineHeight) * 24
    }

    private var calculatedMaxHeight: CGFloat {
        CGFloat(maxLineHeight) * 24
    }

    private enum ValidationState {
        case normal, success, warning, error

        var color: Color {
            switch self {
            case .normal: return .gray.opacity(0.3)
            case .success: return .green.opacity(0.7)
            case .warning: return .orange.opacity(0.8)
            case .error: return .red.opacity(0.8)
            }
        }

        var iconName: String {
            switch self {
            case .normal: return ""
            case .success: return "checkmark.circle.fill"
            case .warning: return "exclamationmark.circle.fill"
            case .error: return "xmark.circle.fill"
            }
        }
    }

    #if os(iOS)
    public init(
        icon: String? = nil,
        title: String,
        text: Binding<String>,
        placeholder: String = "",
        helperText: String? = nil,
        errorMessage: String? = nil,
        characterLimit: Int? = nil,
        minLineHeight: Int = 4,
        maxLineHeight: Int = 10,
        iconColor: Color? = nil,
        isRequired: Bool = false,
        designKit: DesignKit,
        keyboardType: UIKeyboardType = .default,
        contentType: UITextContentType? = nil
    ) {
        self.icon = icon
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.characterLimit = characterLimit
        self.minLineHeight = minLineHeight
        self.maxLineHeight = maxLineHeight
        self.iconColor = iconColor ?? designKit.primary
        self.isRequired = isRequired
        self.designKit = designKit
        self.keyboardType = keyboardType
        self.contentType = contentType
    }
    #else
    public init(
        icon: String? = nil,
        title: String,
        text: Binding<String>,
        placeholder: String = "",
        helperText: String? = nil,
        errorMessage: String? = nil,
        characterLimit: Int? = nil,
        minLineHeight: Int = 4,
        maxLineHeight: Int = 10,
        iconColor: Color? = nil,
        isRequired: Bool = false,
        designKit: DesignKit
    ) {
        self.icon = icon
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.characterLimit = characterLimit
        self.minLineHeight = minLineHeight
        self.maxLineHeight = maxLineHeight
        self.iconColor = iconColor ?? designKit.primary
        self.isRequired = isRequired
        self.designKit = designKit
    }
    #endif

    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            // Main text editor container
            HStack(alignment: .top, spacing: Spacing.md) {
                // Icon section (similar to MenuListItem)
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    // Title with required indicator and character count
                    HStack(spacing: Spacing.xxs) {
                        Text(title)
                            .footnote(designKit)
                            .foregroundStyle(isFocused ? .primary : .secondary)

                        if isRequired {
                            Text("*")
                                .footnote(designKit)
                                .foregroundStyle(.red.opacity(0.7))
                        }

                        Spacer()

                        // Character count
                        if let limit = characterLimit {
                            Text("\(text.count) / \(limit)")
                                .caption(designKit)
                                .foregroundStyle(isOverLimit ? .red.opacity(0.8) : .secondary)
                                .monospacedDigit()
                        }

                        // Validation icon
                        if !validationState.iconName.isEmpty && validationState != .normal {
                            Image(systemName: validationState.iconName)
                                .caption(designKit)
                                .foregroundStyle(validationState.color)
                        }
                    }

                    // Text editor with placeholder
                    ZStack(alignment: .topLeading) {
                        if text.isEmpty {
                            Text(placeholder)
                                .body(designKit)
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                                .allowsHitTesting(false)
                        }

                        #if os(iOS)
                        TextEditor(text: $text)
                            .frame(minHeight: calculatedMinHeight)
                            .frame(maxHeight: calculatedMaxHeight)
                            .scrollContentBackground(.hidden)
                            .body(designKit)
                            .foregroundStyle(.primary)
                            .focused($isFocused)
                            .keyboardType(keyboardType)
                            .textContentType(contentType)
                        #else
                        TextEditor(text: $text)
                            .frame(minHeight: calculatedMinHeight)
                            .frame(maxHeight: calculatedMaxHeight)
                            .scrollContentBackground(.hidden)
                            .body(designKit)
                            .foregroundStyle(.primary)
                            .focused($isFocused)
                        #endif
                    }
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.md)
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
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.3), trigger: isFocused)
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                isPressed = pressing
            })

            // Helper text or error message
            if let message = errorMessage, !message.isEmpty {
                Text(message)
                    .caption(designKit)
                    .foregroundStyle(.red.opacity(0.8))
                    .padding(.horizontal, Spacing.md)
            } else if isOverLimit, let limit = characterLimit {
                Text("Character limit exceeded (\(text.count)/\(limit))")
                    .caption(designKit)
                    .foregroundStyle(.red.opacity(0.8))
                    .padding(.horizontal, Spacing.md)
            } else if let helper = helperText, !helper.isEmpty {
                Text(helper)
                    .caption(designKit)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, Spacing.md)
            }
        }
    }

    private var iconView: some View {
        ZStack {
            // Gradient background (similar to MenuListItem)
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
            Image(systemName: icon!)
                .tickerTitle(designKit)
                .foregroundStyle(
                    isFocused ? Color(.systemGray) : iconColor.opacity(0.8)
                )
        }
        .scaleEffect(isFocused ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }

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

    private var strokeColor: Color {
        if isFocused {
            return .gray.opacity(0.4).opacity(0.8)
        } else if validationState == .error {
            return .red.opacity(0.4)
        } else if validationState == .warning && isRequired && text.isEmpty {
            return .orange.opacity(0.4)
        } else {
            return .gray.opacity(0.6)
        }
    }
}

#Preview("Text Editor Examples") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Text Editor Components")
                .title2(designKit)
                .padding(.horizontal)

            VStack(spacing: Spacing.md) {
                TextEditorItem(
                    icon: "text.alignleft",
                    title: "Description",
                    text: .constant(""),
                    placeholder: "Enter product description...",
                    helperText: "Provide a detailed description of your product",
                    characterLimit: 500,
                    iconColor: .blue,
                    isRequired: true,
                    designKit: designKit
                )

                TextEditorItem(
                    icon: "note.text",
                    title: "Notes",
                    text: .constant("This is a sample note with some text already filled in to demonstrate how the text editor handles multi-line content."),
                    placeholder: "Enter notes...",
                    helperText: "Add any additional notes or comments",
                    iconColor: .green,
                    designKit: designKit
                )

                TextEditorItem(
                    icon: "bubble.left.and.bubble.right.fill",
                    title: "Comments",
                    text: .constant(""),
                    placeholder: "Add your comments here...",
                    characterLimit: 200,
                    iconColor: .purple,
                    designKit: designKit
                )

                TextEditorItem(
                    title: "Feedback",
                    text: .constant("Great product! I really enjoyed using it. The quality is excellent and it exceeded my expectations. Would definitely recommend to others."),
                    placeholder: "Enter your feedback...",
                    helperText: "Your feedback helps us improve",
                    designKit: designKit
                )
            }
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

#Preview("Validation States") {
    let designKit = DesignKit(.default)
    return VStack(spacing: Spacing.lg) {
        Text("Text Editor Validation States")
            .title2(designKit)
            .padding(.horizontal)

        VStack(spacing: Spacing.sm) {
            TextEditorItem(
                icon: "checkmark.circle.fill",
                title: "Valid Text Editor",
                text: .constant("This is valid multi-line text content that meets all requirements."),
                placeholder: "Enter text",
                iconColor: .green,
                designKit: designKit
            )

            TextEditorItem(
                icon: "exclamationmark.triangle.fill",
                title: "Required Field",
                text: .constant(""),
                placeholder: "This field is required",
                helperText: "Please fill in this required field",
                iconColor: .orange,
                isRequired: true,
                designKit: designKit
            )

            TextEditorItem(
                icon: "xmark.circle.fill",
                title: "Character Limit Exceeded",
                text: .constant("This text is way too long and exceeds the character limit that was set for this field. You can see the validation error below."),
                placeholder: "Enter text",
                characterLimit: 50,
                iconColor: .red,
                designKit: designKit
            )

            TextEditorItem(
                icon: "info.circle.fill",
                title: "Error Message",
                text: .constant("Some invalid content"),
                placeholder: "Enter text",
                errorMessage: "This content contains invalid characters",
                iconColor: .red,
                designKit: designKit
            )
        }
        .padding(.horizontal)

        Spacer()
    }
    .background(.gray.opacity(0.1))
}
