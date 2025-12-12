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
            case .normal: return Color(.systemGray2)
            case .success: return Color(.systemGreen).opacity(0.7)
            case .warning: return Color(.systemOrange).opacity(0.8)
            case .error: return Color(.systemRed).opacity(0.8)
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
        iconColor: Color = DesignKit.primary,
        isRequired: Bool = false,
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
        self.iconColor = iconColor
        self.isRequired = isRequired
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
        iconColor: Color = DesignKit.primary,
        isRequired: Bool = false,
        submitLabel: SubmitLabel = .done,
        onSubmit: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.iconColor = iconColor
        self.isRequired = isRequired
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
    }
    #endif
    
    public var body: some View {
        VStack(alignment: .leading, spacing: DesignKit.xxs) {
            // Main text field container
            HStack(spacing: DesignKit.md) {
                // Icon section (similar to MenuListItem)
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: DesignKit.xxs) {
                    // Title with required indicator
                    HStack(spacing: DesignKit.xxs) {
                        Text(title)
                            .footnote()
                            .foregroundStyle(isFocused ? .primary : .secondary)

                        if isRequired {
                            Text("*")
                                .footnote()
                                .foregroundStyle(Color(.systemRed).opacity(0.7))
                        }

                        Spacer()

                        // Validation icon
                        if !validationState.iconName.isEmpty && validationState != .normal {
                            Image(systemName: validationState.iconName)
                                .caption()
                                .foregroundStyle(validationState.color)
                        }
                    }
                    
                    // Text field
                    #if os(iOS)
                    TextField(placeholder, text: $text)
                        .body()
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
                        .body()
                        .foregroundStyle(.primary)
                        .focused($isFocused)
                        .submitLabel(submitLabel)
                        .onSubmit {
                            onSubmit?()
                        }
                    #endif
                }
            }
            .padding(.horizontal, DesignKit.md)
            .padding(.vertical, DesignKit.sm + 4)
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
            
            // Helper text or error message
            if let message = errorMessage, !message.isEmpty {
                Text(message)
                    .caption()
                    .foregroundStyle(Color(.systemRed).opacity(0.8))
                    .padding(.horizontal, DesignKit.md)
            } else if let helper = helperText, !helper.isEmpty {
                Text(helper)
                    .caption()
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, DesignKit.md)
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
            Image(systemName: icon!)
                .tickerTitle()
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
    
    private var strokeColor: Color {
        if isFocused {
            return Color(.systemGray3).opacity(0.8)
        } else if validationState == .error {
            return Color(.systemRed).opacity(0.4)
        } else if validationState == .warning && isRequired && text.isEmpty {
            return Color(.systemOrange).opacity(0.4)
        } else {
            return Color(.systemGray5)
        }
    }
}

#Preview("Text Field Examples") {
    ScrollView {
        VStack(spacing: DesignKit.lg) {
            Text("Text Field Components")
                .title2()
                .padding(.horizontal)

            VStack(spacing: DesignKit.md) {
                TextFieldItem(
                    icon: "person.fill",
                    title: "Full Name",
                    text: .constant(""),
                    placeholder: "Enter your full name",
                    helperText: "This will be displayed on your profile",
                    isRequired: true
                )
                
                TextFieldItem(
                    icon: "envelope.fill",
                    title: "Email Address",
                    text: .constant("john.doe@example.com"),
                    placeholder: "Enter your email",
                    iconColor: .blue,
                    keyboardType: .emailAddress,
                    contentType: .emailAddress
                )
                
                TextFieldItem(
                    icon: "phone.fill",
                    title: "Phone Number",
                    text: .constant(""),
                    placeholder: "(555) 123-4567",
                    iconColor: .green,
                    isRequired: true,
                    keyboardType: .phonePad,
                    contentType: .telephoneNumber
                )
                
                TextFieldItem(
                    icon: "calendar",
                    title: "Date of Birth",
                    text: .constant("March 15, 1985"),
                    placeholder: "Select date",
                    helperText: "Used for age calculations",
                    iconColor: .purple
                )
                
                TextFieldItem(
                    icon: "heart.text.square",
                    title: "Blood Type",
                    text: .constant(""),
                    placeholder: "e.g. A+, O-, B+",
                    errorMessage: "Please enter a valid blood type",
                    iconColor: .red
                )
                
                TextFieldItem(
                    title: "Notes",
                    text: .constant("Patient has a history of hypertension"),
                    placeholder: "Additional notes...",
                    helperText: "Optional additional information"
                )
            }
            .padding(.horizontal)
        }
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Validation States") {
    VStack(spacing: DesignKit.lg) {
        Text("Validation States")
            .title2()
            .padding(.horizontal)

        VStack(spacing: DesignKit.sm) {
            TextFieldItem(
                icon: "checkmark.circle.fill",
                title: "Valid Field",
                text: .constant("Valid input"),
                placeholder: "Enter text",
                iconColor: .green
            )
            
            TextFieldItem(
                icon: "exclamationmark.triangle.fill",
                title: "Required Field",
                text: .constant(""),
                placeholder: "This field is required",
                iconColor: .orange,
                isRequired: true
            )
            
            TextFieldItem(
                icon: "xmark.circle.fill",
                title: "Error Field",
                text: .constant("invalid@"),
                placeholder: "Enter email",
                errorMessage: "Please enter a valid email address",
                iconColor: .red
            )
        }
        .padding(.horizontal)
        
        Spacer()
    }
    .background(Color(.systemGroupedBackground))
}
