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
    private let designKit: DesignKit
    
    @Binding private var selectedDate: Date?
    @State private var isPressed = false
    @State private var showingPicker = false
    @State private var hapticCounter = 0
    
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
        iconColor: Color? = nil,
        isRequired: Bool = false,
        displayedComponents: DatePicker.Components = [.date],
        designKit: DesignKit
    ) {
        self.icon = icon
        self.title = title
        self._selectedDate = selectedDate
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.iconColor = iconColor ?? designKit.primary
        self.isRequired = isRequired
        self.displayedComponents = displayedComponents
        self.designKit = designKit
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            // Main date picker container
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
                            .footnote(designKit)
                            .foregroundStyle(.secondary)
                        
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
                    
                    // Selected date or placeholder
                    HStack {
                        if let date = selectedDate {
                            Text(formatDate(date))
                                .body(designKit)
                                .foregroundStyle(.primary)
                        } else {
                            Text("Select date")
                                .body(designKit)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .caption(designKit)
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
            .onTapGesture {
                hapticCounter += 1
                showingPicker = true
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: hapticCounter)
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
                        #if os(iOS)
                        .datePickerStyle(.wheel)
                        #endif
                        .labelsHidden()

                        Spacer()
                    }
                    .padding()
                    .navigationTitle(title)
                    #if os(iOS)
                    .toolbarTitleDisplayMode(.inlineLarge)
                    #endif
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingPicker = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                showingPicker = false
                            }
                        }
                    }
                }
                .presentationDetents([.medium])
            }
            
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
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

            Circle()
                .stroke(iconColor.opacity(0.12), lineWidth: 1)
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)
            
            Image(systemName: icon!)
                .tickerTitle(designKit)
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
        } else if validationState == .warning && isRequired && selectedDate == nil {
            return .orange.opacity(0.4)
        } else {
            return .gray.opacity(0.6)
        }
    }
}
