//
//  TextFieldItem.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 08/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Elegant text field component with MenuListItem-inspired design
public struct TextFieldItem: View {
    private let icon: String?
    private let title: String
    private let placeholder: String
    private let helperText: String?
    private let errorMessage: String?
    private let iconColor: Color
    private let isRequired: Bool
    private let designKit: DesignKit
    #if os(iOS)
    private let keyboardType: UIKeyboardType
    private let contentType: UITextContentType?
    #endif
    private let submitLabel: SubmitLabel
    private let onSubmit: (() -> Void)?
    
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    @State private var isPressed = false
    
    private var validationState: ValidationState {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error
        } else if isRequired && text.isEmpty {
            return .warning
        } else if !text.isEmpty {
            return .success
        } else {
            return .normal
        }
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
        iconColor: Color? = nil,
        isRequired: Bool = false,
        designKit: DesignKit,
        keyboardType: UIKeyboardType = .default,
        contentType: UITextContentType? = nil,
        submitLabel: SubmitLabel = .done,
        onSubmit: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.iconColor = iconColor ?? designKit.primary
        self.isRequired = isRequired
        self.designKit = designKit
        self.keyboardType = keyboardType
        self.contentType = contentType
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
    }
    #else
    public init(
        icon: String? = nil,
        title: String,
        text: Binding<String>,
        placeholder: String = "",
        helperText: String? = nil,
        errorMessage: String? = nil,
        iconColor: Color? = nil,
        isRequired: Bool = false,
        designKit: DesignKit,
        submitLabel: SubmitLabel = .done,
        onSubmit: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.iconColor = iconColor ?? designKit.primary
        self.isRequired = isRequired
        self.designKit = designKit
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
    }
    #endif
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            // Main text field container
            HStack(spacing: Spacing.md) {
                // Icon section (similar to MenuListItem)
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    // Title with required indicator
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

                        // Validation icon
                        if !validationState.iconName.isEmpty && validationState != .normal {
                            Image(systemName: validationState.iconName)
                                .caption(designKit)
                                .foregroundStyle(validationState.color)
                        }
                    }
                    
                    // Text field
                    #if os(iOS)
                    TextField(placeholder, text: $text)
                        .body(designKit)
                        .foregroundStyle(.primary)
                        .focused($isFocused)
                        .keyboardType(keyboardType)
                        .textContentType(contentType)
                        .submitLabel(submitLabel)
                        .onSubmit {
                            onSubmit?()
                        }
                    #else
                    TextField(placeholder, text: $text)
                        .body(designKit)
                        .foregroundStyle(.primary)
                        .focused($isFocused)
                        .submitLabel(submitLabel)
                        .onSubmit {
                            onSubmit?()
                        }
                    #endif
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm + 4)
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

#Preview("Text Field Examples") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Text Field Components")
                .title2(designKit)
                .padding(.horizontal)

            VStack(spacing: Spacing.md) {
                TextFieldItem(
                    icon: "person.fill",
                    title: "Full Name",
                    text: .constant(""),
                    placeholder: "Enter your full name",
                    helperText: "This will be displayed on your profile",
                    isRequired: true,
                    designKit: designKit
                )
                
                TextFieldItem(
                    icon: "envelope.fill",
                    title: "Email Address",
                    text: .constant("john.doe@example.com"),
                    placeholder: "Enter your email",
                    iconColor: .blue,
                    designKit: designKit
                )
                
                TextFieldItem(
                    icon: "phone.fill",
                    title: "Phone Number",
                    text: .constant(""),
                    placeholder: "(555) 123-4567",
                    iconColor: .green,
                    isRequired: true,
                    designKit: designKit
                )
                
                TextFieldItem(
                    icon: "calendar",
                    title: "Date of Birth",
                    text: .constant("March 15, 1985"),
                    placeholder: "Select date",
                    helperText: "Used for age calculations",
                    iconColor: .purple,
                    designKit: designKit
                )
                
                TextFieldItem(
                    icon: "heart.text.square",
                    title: "Blood Type",
                    text: .constant(""),
                    placeholder: "e.g. A+, O-, B+",
                    errorMessage: "Please enter a valid blood type",
                    iconColor: .red,
                    designKit: designKit
                )
                
                TextFieldItem(
                    title: "Notes",
                    text: .constant("Patient has a history of hypertension"),
                    placeholder: "Additional notes...",
                    helperText: "Optional additional information",
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
        Text("Validation States")
            .title2(designKit)
            .padding(.horizontal)

        VStack(spacing: Spacing.sm) {
            TextFieldItem(
                icon: "checkmark.circle.fill",
                title: "Valid Field",
                text: .constant("Valid input"),
                placeholder: "Enter text",
                iconColor: .green,
                designKit: designKit
            )
            
            TextFieldItem(
                icon: "exclamationmark.triangle.fill",
                title: "Required Field",
                text: .constant(""),
                placeholder: "This field is required",
                iconColor: .orange,
                isRequired: true,
                designKit: designKit
            )
            
            TextFieldItem(
                icon: "xmark.circle.fill",
                title: "Error Field",
                text: .constant("invalid@"),
                placeholder: "Enter email",
                errorMessage: "Please enter a valid email address",
                iconColor: .red,
                designKit: designKit
            )
        }
        .padding(.horizontal)
        
        Spacer()
    }
    .background(.gray.opacity(0.1))
}
