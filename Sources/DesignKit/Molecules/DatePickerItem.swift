//
//  DatePickerItem.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 06/09/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

// MARK: - Date Picker Item

/// Date picker component with TextFieldItem styling
public struct DatePickerItem: View {
    private let icon: String?
    private let title: String
    private let helperText: String?
    private let errorMessage: String?
    private let iconColor: Color
    private let isRequired: Bool
    private let displayedComponents: DatePicker.Components
    
    @Binding private var selectedDate: Date?
    @State private var isPressed = false
    @State private var showingPicker = false
    
    private var validationState: ValidationState {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error
        } else if isRequired && selectedDate == nil {
            return .warning
        } else if selectedDate != nil {
            return .success
        } else {
            return .normal
        }
    }
    
    public init(
        icon: String? = nil,
        title: String,
        selectedDate: Binding<Date?>,
        helperText: String? = nil,
        errorMessage: String? = nil,
        iconColor: Color = DesignKit.primary,
        isRequired: Bool = false,
        displayedComponents: DatePicker.Components = [.date]
    ) {
        self.icon = icon
        self.title = title
        self._selectedDate = selectedDate
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.iconColor = iconColor
        self.isRequired = isRequired
        self.displayedComponents = displayedComponents
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: DesignKit.xxs) {
            // Main date picker container
            HStack(spacing: DesignKit.md) {
                // Icon section
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: DesignKit.xxs) {
                    // Title with required indicator
                    HStack(spacing: DesignKit.xxs) {
                        Text(title)
                            .footnote()
                            .foregroundStyle(.secondary)
                        
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
                    
                    // Selected date or placeholder
                    HStack {
                        if let date = selectedDate {
                            Text(formatDate(date))
                                .body()
                                .foregroundStyle(.primary)
                        } else {
                            Text("Select date")
                                .body()
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .caption()
                            .foregroundStyle(.tertiary)
                    }
                }
            }
            .padding(.horizontal, DesignKit.md)
            .padding(.vertical, DesignKit.sm + 4)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusMedium))
            .overlay(
                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .stroke(strokeColor, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.99 : 1.0)
            .animation(DesignKit.animationQuick, value: isPressed)
            .shadow(
                color: DesignKit.shadowSubtle.color,
                radius: DesignKit.shadowSubtle.radius,
                x: DesignKit.shadowSubtle.x,
                y: DesignKit.shadowSubtle.y
            )
            .onTapGesture {
                showingPicker = true
            }
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                isPressed = pressing
            })
            .sheet(isPresented: $showingPicker) {
                NavigationView {
                    VStack {
                        DatePicker(
                            "Select Date",
                            selection: Binding(
                                get: { selectedDate ?? Date() },
                                set: { selectedDate = $0 }
                            ),
                            displayedComponents: displayedComponents
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle(title)
                    .toolbarTitleDisplayMode(.inlineLarge)
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showingPicker = false
                        },
                        trailing: Button("Done") {
                            showingPicker = false
                        }
                    )
                }
                .presentationDetents([.medium])
            }
            
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
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        if displayedComponents == [.date] {
            formatter.dateStyle = .medium
        } else if displayedComponents == [.hourAndMinute] {
            formatter.timeStyle = .short
        } else {
            formatter.dateStyle = .short
            formatter.timeStyle = .short
        }
        return formatter.string(from: date)
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
                .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)

            Circle()
                .stroke(iconColor.opacity(0.12), lineWidth: 1)
                .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)
            
            Image(systemName: icon!)
                .tickerTitle()
                .foregroundStyle(iconColor.opacity(0.8))
        }
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
            .fill(isPressed ? Color(.systemGray6) : Color(.systemBackground))
    }
    
    private var strokeColor: Color {
        if validationState == .error {
            return Color(.systemRed).opacity(0.4)
        } else if validationState == .warning && isRequired && selectedDate == nil {
            return Color(.systemOrange).opacity(0.4)
        } else {
            return Color(.systemGray5)
        }
    }
}
