//
//  MenuListItem.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 06/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// Rich, modern menu list item with enhanced visual design
public struct MenuListItem: View {
    private let icon: String
    private let title: String
    private let subtitle: String?
    private let iconColor: Color
    private let hasChevron: Bool
    private let badge: Int?
    private let action: () -> Void
    
    @State private var isPressed = false
    
    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        iconColor: Color = DesignKit.primary,
        hasChevron: Bool = true,
        badge: Int? = nil,
        action: @escaping () -> Void = {}
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.iconColor = iconColor
        self.hasChevron = hasChevron
        self.badge = badge
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: DesignKit.md) {
                // Enhanced icon with gradient background
                iconView

                // Content section
                VStack(alignment: .leading, spacing: DesignKit.xxs) {
                    HStack(alignment: .center, spacing: DesignKit.xs) {
                        Text(title)
                            .footnote()
                            .foregroundStyle(.primary)

                        if let badge = badge {
                            badgeView(count: badge)
                        }

                        Spacer()
                    }

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .caption()
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
                
                // Chevron with enhanced styling
                if hasChevron {
                    chevronView
                }
            }
            .padding(.horizontal, DesignKit.md)
            .padding(.vertical, DesignKit.sm + 2)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: DesignKit.radiusMedium))
            .overlay(
                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .stroke(Color.clear, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .contentShape(.rect)
            .animation(DesignKit.animationQuick, value: isPressed)
            .shadow(
                color: DesignKit.shadowSubtle.color,
                radius: DesignKit.shadowSubtle.radius,
                x: DesignKit.shadowSubtle.x,
                y: DesignKit.shadowSubtle.y
            )
        }
        .buttonStyle(.plain)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
            isPressed = pressing
        })
    }
    
    private var iconView: some View {
        ZStack {
            // Gradient background
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            iconColor.opacity(0.1),
                            iconColor.opacity(0.2)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)

            // Subtle ring
            Circle()
                .stroke(iconColor.opacity(0.15), lineWidth: 1)
                .frame(width: DesignKit.tapTargetMin, height: DesignKit.tapTargetMin)
            
            // Icon
            Image(systemName: icon)
                .tickerTitle()
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            iconColor,
                            iconColor.opacity(0.8)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
    
    private var backgroundView: some View {
        Group {

                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .fill(isPressed ? Color(.systemGray6) : .clear)
        }
    }
    
    private var chevronView: some View {
        Image(systemName: "chevron.right")
            .smallText()
            .foregroundStyle(.tertiary)
            .scaleEffect(isPressed ? 1.1 : 1.0)
            .animation(DesignKit.animationQuick, value: isPressed)
    }
    
    private func badgeView(count: Int) -> some View {
        Text("\(count)")
            .caption2()
            .foregroundStyle(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .red.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .shadow(color: .red.opacity(0.3), radius: 2, x: 0, y: 1)
    }
}


#Preview("Standard Menu Items") {
    ScrollView {
        VStack(spacing: DesignKit.xs) {
            MenuListItem(
                icon: "book.fill",
                title: "Diary",
                subtitle: "Track your daily health entries",
                iconColor: DesignKit.primary,
                badge: 3
            )
            
            MenuListItem(
                icon: "leaf.fill",
                title: "Nutrition",
                subtitle: "Manage your meal plans",
                iconColor: .green
            )
            
            MenuListItem(
                icon: "chart.line.uptrend.xyaxis",
                title: "Monitoring",
                subtitle: "View health trends and analytics",
                iconColor: .blue
            )
            
            MenuListItem(
                icon: "questionmark.circle.fill",
                title: "Knowledge Base",
                subtitle: "Get answers to health questions",
                iconColor: DesignKit.primary
            )

            MenuListItem(
                icon: "bell.fill",
                title: "Alarms & Reminders",
                subtitle: "Medication and appointment alerts",
                iconColor: .orange,
                badge: 12
            )

            MenuListItem(
                icon: "heart.text.square",
                title: "Biomarkers",
                subtitle: "Lab results and health metrics",
                iconColor: DesignKit.primary
            )

            MenuListItem(
                icon: "pills.fill",
                title: "Medications",
                subtitle: "Prescription management",
                iconColor: DesignKit.primary,
                badge: 1
            )
            
            MenuListItem(
                icon: "gearshape.fill",
                title: "Settings",
                subtitle: "App preferences and account",
                iconColor: .gray
            )
            
            MenuListItem(
                icon: "rectangle.portrait.and.arrow.right",
                title: "Log Out",
                iconColor: .red,
                hasChevron: false
            )
        }
        .padding(.horizontal)
    }
}

#Preview("Different States") {
    VStack(spacing: DesignKit.md) {
        Text("Menu Item States")
            .title2()
            .padding(.horizontal)

        VStack(spacing: DesignKit.xs) {
            MenuListItem(
                icon: "heart.fill",
                title: "Normal State",
                subtitle: "Regular menu item",
                iconColor: DesignKit.primary
            )
            
            MenuListItem(
                icon: "star.fill",
                title: "Selected State",
                subtitle: "Currently active item",
                iconColor: .orange
            )
            
            MenuListItem(
                icon: "bell.fill",
                title: "With Badge",
                subtitle: "Has notification count",
                iconColor: .blue,
                badge: 99
            )
            
            MenuListItem(
                icon: "trash.fill",
                title: "No Chevron",
                subtitle: "Action item without navigation",
                iconColor: .red,
                hasChevron: false
            )
            
            MenuListItem(
                icon: "sparkles",
                title: "Just Title",
                iconColor: .purple
            )
        }
        .padding(.horizontal)
        
        Spacer()
    }
}
