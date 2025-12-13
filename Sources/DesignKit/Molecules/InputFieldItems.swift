//
//  InputFieldItems.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 08/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

// MARK: - Menu Picker Item

/// Menu picker component with TextFieldItem styling
public struct MenuPickerItem<T: Hashable & CustomStringConvertible>: View {
    private let icon: String?
    private let title: String
    private let options: [T]
    private let helperText: String?
    private let errorMessage: String?
    private let iconColor: Color
    private let isRequired: Bool
    private let placeholder: String
    
    @Binding private var selectedOption: T?
    @State private var isPressed = false
    
    private var validationState: ValidationState {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error
        } else if isRequired && selectedOption == nil {
            return .warning
        } else if selectedOption != nil {
            return .success
        } else {
            return .normal
        }
    }
    
    public init(
        icon: String? = nil,
        title: String,
        selectedOption: Binding<T?>,
        options: [T],
        placeholder: String = "Select an option",
        helperText: String? = nil,
        errorMessage: String? = nil,
        iconColor: Color = DesignKit.primary,
        isRequired: Bool = false
    ) {
        self.icon = icon
        self.title = title
        self._selectedOption = selectedOption
        self.options = options
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.iconColor = iconColor
        self.isRequired = isRequired
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            // Main picker container
            HStack(spacing: Spacing.md) {
                // Icon section
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    // Title with required indicator
                    HStack(spacing: Spacing.xxs) {
                        Text(title)
                            .footnote()
                            .foregroundStyle(.secondary)
                        
                        if isRequired {
                            Text("*")
                                .footnote()
                                .foregroundStyle(.red.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        // Validation icon
                        if !validationState.iconName.isEmpty && validationState != .normal {
                            Image(systemName: validationState.iconName)
                                .caption()
                                .foregroundStyle(validationState.color)
                        }
                    }
                    
                    // Selected value or placeholder
                    HStack {
                        Text(selectedOption?.description ?? placeholder)
                            .body()
                            .foregroundStyle(selectedOption != nil ? .primary : .secondary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.up.chevron.down")
                            .caption()
                            .foregroundStyle(.tertiary)
                    }
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm + 4)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: Radius.medium))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.medium)
                    .stroke(strokeColor, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.99 : 1.0)
            .animation(Animation.quick, value: isPressed)
            .shadow(
                color: Shadow.subtle.color,
                radius: Shadow.subtle.radius,
                x: Shadow.subtle.x,
                y: Shadow.subtle.y
            )
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                isPressed = pressing
            })
            .overlay(
                Menu {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                        }) {
                            Text(option.description)
                        }
                    }
                } label: {
                    Color.clear
                        .contentShape(Rectangle())
                }
            )
            
            // Helper text or error message
            if let message = errorMessage, !message.isEmpty {
                Text(message)
                    .caption()
                    .foregroundStyle(.red.opacity(0.8))
                    .padding(.horizontal, Spacing.md)
            } else if let helper = helperText, !helper.isEmpty {
                Text(helper)
                    .caption()
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, Spacing.md)
            }
        }
    }
    
    private var iconView: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            iconColor.opacity(0.08),
                            iconColor.opacity(0.12)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

            Circle()
                .stroke(iconColor.opacity(0.12), lineWidth: 1)
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)
            
            Image(systemName: icon!)
                .tickerTitle()
                .foregroundStyle(iconColor.opacity(0.8))
        }
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: Radius.medium)
            .fill(isPressed ? .gray.opacity(0.7) : .white.opacity(0.95))
    }

    private var strokeColor: Color {
        if validationState == .error {
            return .red.opacity(0.4)
        } else if validationState == .warning && isRequired && selectedOption == nil {
            return .orange.opacity(0.4)
        } else {
            return .gray.opacity(0.6)
        }
    }
}



// MARK: - Toggle Item

/// Toggle switch component with TextFieldItem styling
public struct ToggleItem: View {
    private let icon: String?
    private let title: String
    private let subtitle: String?
    private let helperText: String?
    private let iconColor: Color
    
    @Binding private var isOn: Bool
    @State private var isPressed = false
    
    public init(
        icon: String? = nil,
        title: String,
        subtitle: String? = nil,
        isOn: Binding<Bool>,
        helperText: String? = nil,
        iconColor: Color = DesignKit.primary
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
        self.helperText = helperText
        self.iconColor = iconColor
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            // Main toggle container
            HStack(spacing: Spacing.md) {
                // Icon section
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .font(.system(.body, design: .rounded, weight: .medium))
                        .foregroundStyle(.primary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .caption()
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                // Toggle switch
                Toggle("", isOn: $isOn)
                    .labelsHidden()
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm + 4)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: Radius.medium))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.medium)
                    .stroke(.gray.opacity(0.6), lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.99 : 1.0)
            .animation(Animation.quick, value: isPressed)
            .shadow(
                color: Shadow.subtle.color,
                radius: Shadow.subtle.radius,
                x: Shadow.subtle.x,
                y: Shadow.subtle.y
            )
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                isPressed = pressing
            })
            
            // Helper text
            if let helper = helperText, !helper.isEmpty {
                Text(helper)
                    .caption()
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, Spacing.md)
            }
        }
    }

    private var iconView: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            iconColor.opacity(0.08),
                            iconColor.opacity(0.12)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

            Circle()
                .stroke(iconColor.opacity(0.12), lineWidth: 1)
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)
            
            Image(systemName: icon!)
                .tickerTitle()
                .foregroundStyle(iconColor.opacity(0.8))
        }
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: Radius.medium)
            .fill(isPressed ? .gray.opacity(0.7) : .white.opacity(0.95))
    }
}

// MARK: - Validation State Helper

public enum ValidationState {
    case normal, success, warning, error
    
    public var color: Color {
        switch self {
        case .normal: return .gray.opacity(0.3)
        case .success: return .green.opacity(0.7)
        case .warning: return .orange.opacity(0.8)
        case .error: return .red.opacity(0.8)
        }
    }
    
    public var iconName: String {
        switch self {
        case .normal: return ""
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

// MARK: - Previews

enum BloodType: String, CaseIterable, CustomStringConvertible {
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case oPositive = "O+"
    case oNegative = "O-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    
    var description: String { rawValue }
}

enum Gender: String, CaseIterable, CustomStringConvertible {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    case preferNotToSay = "Prefer not to say"
    
    var description: String { rawValue }
}

#Preview("Menu Picker Examples") {


     ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Menu Picker Examples")
                .title2()
                .fontWeight(.bold)
                .padding(.horizontal)

            VStack(spacing: Spacing.md) {
                MenuPickerItem(
                    icon: "drop.fill",
                    title: "Blood Type",
                    selectedOption: .constant(BloodType.aPositive),
                    options: BloodType.allCases,
                    helperText: "Select your blood type",
                    iconColor: .red
                )
                
                MenuPickerItem(
                    icon: "person.fill",
                    title: "Gender",
                    selectedOption: .constant(nil),
                    options: Gender.allCases,
                    placeholder: "Select gender",
                    iconColor: .purple,
                    isRequired: true
                )
                
                MenuPickerItem(
                    title: "Priority Level",
                    selectedOption: .constant(nil),
                    options: ["Low", "Medium", "High", "Critical"],
                    errorMessage: "Please select a priority level"
                )
            }
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

#Preview("Date Picker Examples") {
    ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Date Picker Examples")
                .title2()
                .fontWeight(.bold)
                .padding(.horizontal)

            VStack(spacing: Spacing.md) {
                DatePickerItem(
                    icon: "calendar",
                    title: "Date of Birth",
                    selectedDate: .constant(nil),
                    helperText: "Used for age calculations",
                    iconColor: .blue,
                    isRequired: true
                )
                
                DatePickerItem(
                    icon: "clock.fill",
                    title: "Appointment Time",
                    selectedDate: .constant(Date()),
                    iconColor: .green,
                    displayedComponents: [.hourAndMinute]
                )
                
                DatePickerItem(
                    title: "Last Updated",
                    selectedDate: .constant(Date()),
                    displayedComponents: [.date, .hourAndMinute]
                )
            }
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

#Preview("Toggle Examples") {
    ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Toggle Examples")
                .title2()
                .fontWeight(.bold)
                .padding(.horizontal)

            VStack(spacing: Spacing.md) {
                ToggleItem(
                    icon: "bell.fill",
                    title: "Medication Reminders",
                    subtitle: "Get notified when it's time to take medication",
                    isOn: .constant(true),
                    helperText: "Push notifications will be sent to your device",
                    iconColor: .orange
                )
                
                ToggleItem(
                    icon: "heart.fill",
                    title: "Health Data Sharing",
                    isOn: .constant(false),
                    iconColor: .red
                )
                
                ToggleItem(
                    title: "Emergency Contacts Access",
                    subtitle: "Allow emergency contacts to view your health information",
                    isOn: .constant(true)
                )
            }
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

#Preview("All Input Types") {
    ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("All Input Types")
                .title2()
                .fontWeight(.bold)
                .padding(.horizontal)

            VStack(spacing: Spacing.md) {
                TextFieldItem(
                    icon: "person.fill",
                    title: "Full Name",
                    text: .constant("John Doe"),
                    placeholder: "Enter name"
                )
                
                MenuPickerItem(
                    icon: "drop.fill",
                    title: "Blood Type",
                    selectedOption: .constant("A+"),
                    options: ["A+", "A-", "B+", "B-", "O+", "O-"],
                    iconColor: .red
                )
                
                DatePickerItem(
                    icon: "calendar",
                    title: "Date of Birth",
                    selectedDate: .constant(nil),
                    iconColor: Color.blue,
                    isRequired: true
                )
                
                ToggleItem(
                    icon: "bell.fill",
                    title: "Notifications",
                    isOn: .constant(true),
                    iconColor: Color.orange
                )
            }
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

