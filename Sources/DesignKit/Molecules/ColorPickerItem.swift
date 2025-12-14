//
//  ColorPickerItem.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 11/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// Color picker component with predefined color palette and TextFieldItem styling
public struct ColorPickerItem: View {
    private let icon: String?
    private let title: String
    private let helperText: String?
    private let iconColor: Color
    private let colors: [String]
    
    @Binding private var selectedColorHex: String
    @State private var isPressed = false
    @State private var showingPicker = false
    
    public init(
        icon: String? = nil,
        title: String,
        selectedColorHex: Binding<String>,
        colors: [String] = PatientColor.predefinedColors,
        helperText: String? = nil,
        iconColor: Color = DesignKit.primary
    ) {
        self.icon = icon
        self.title = title
        self._selectedColorHex = selectedColorHex
        self.colors = colors
        self.helperText = helperText
        self.iconColor = iconColor
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            // Main color picker container
            HStack(spacing: Spacing.md) {
                // Icon section
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    // Title
                    Text(title)
                        .footnote()
                        .foregroundStyle(.secondary)
                    
                    // Selected color preview and action
                    HStack {
                        // Color preview circle
                        Circle()
                            .fill(Color(hex: selectedColorHex) ?? .gray)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Circle()
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            )
                        
                        Text("Tap to change color")
                            .body()
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
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
            .onTapGesture {
                showingPicker = true
            }
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                isPressed = pressing
            })
            .sheet(isPresented: $showingPicker) {
                ColorSelectionView(
                    selectedColorHex: $selectedColorHex,
                    colors: colors,
                    title: title
                )
            }
            
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

// MARK: - Color Selection Sheet View

private struct ColorSelectionView: View {
    @Binding var selectedColorHex: String
    let colors: [String]
    let title: String
    
    @Environment(\.dismiss) private var dismiss
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    Text("Choose a theme color for this patient")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(colors, id: \.self) { colorHex in
                            ColorOptionView(
                                colorHex: colorHex,
                                isSelected: selectedColorHex == colorHex,
                                onTap: {
                                    selectedColorHex = colorHex
                                    dismiss()
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, Spacing.md)
            }
            .navigationTitle(title)
            #if os(iOS)
            .toolbarTitleDisplayMode(.inlineLarge)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

// MARK: - Individual Color Option View

private struct ColorOptionView: View {
    let colorHex: String
    let isSelected: Bool
    let onTap: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                // Color circle
                Circle()
                    .fill(Color(hex: colorHex) ?? .gray)
                    .frame(width: 60, height: 60)
                
                // Selection indicator
                if isSelected {
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .stroke(.gray.opacity(0.3), lineWidth: 1)
                        .frame(width: 66, height: 66)
                    
                    Image(systemName: "checkmark")
                        .font(DesignKit.customSize(20, weight: .bold, relativeTo: .title3))
                        .foregroundStyle(.white)
                } else {
                    // Subtle border for unselected
                    Circle()
                        .stroke(.gray.opacity(0.6), lineWidth: 1)
                        .frame(width: 60, height: 60)
                }
            }
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(Animation.quick, value: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
            isPressed = pressing
        })
    }
}

// MARK: - Patient Color Constants

public struct PatientColor {
    public static let predefinedColors: [String] = [
        "#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4",
        "#FFEAA7", "#DDA0DD", "#98D8C8", "#F7DC6F",
        "#BB8FCE", "#85C1E9", "#F8C471", "#82E0AA",
        "#F1948A", "#85C1CC", "#D2B4DE", "#AED6F1",
        "#A3E4D7", "#F9E79F", "#FADBD8", "#D5DBDB"
    ]
}

// MARK: - Color Extension for Hex Support

public extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Previews

#Preview("Color Picker Item") {
    ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Color Picker Component")
                .title2()
                .padding(.horizontal)

            VStack(spacing: Spacing.md) {
                ColorPickerItem(
                    icon: "paintpalette.fill",
                    title: "Theme Color",
                    selectedColorHex: .constant("#FF6B6B"),
                    helperText: "This color will theme the patient's profile"
                )
                
                ColorPickerItem(
                    title: "Primary Color",
                    selectedColorHex: .constant("#4ECDC4")
                )
                
                ColorPickerItem(
                    icon: "circle.fill",
                    title: "Avatar Color",
                    selectedColorHex: .constant("#45B7D1"),
                    helperText: "Used for avatar and accent colors",
                    iconColor: .blue
                )
            }
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}
