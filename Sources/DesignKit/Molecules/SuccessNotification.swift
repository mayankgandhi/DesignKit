//
//  SuccessNotification.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 06/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// Success notification with droplet animation (matching the middle design)
public struct SuccessNotification: View {
    
    private let message: String
    private let timestamp: String
    private let value: String
    private let unit: String
    private let status: String
    @State private var animateDroplet = false
    
    public init(
        message: String = "Success!",
        timestamp: String,
        value: String,
        unit: String,
        status: String
    ) {
        self.message = message
        self.timestamp = timestamp
        self.value = value
        self.unit = unit
        self.status = status
    }
    
    public var body: some View {

        VStack(spacing: Spacing.lg) {
            // Animated droplet
            ZStack {
                // Background droplets
                ForEach(0..<3, id: \.self) { index in
                    Image(systemName: "drop.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(DesignKit.primary.opacity(0.3))
                        .offset(
                            x: CGFloat(index - 1) * 30,
                            y: animateDroplet ? -20 : 0
                        )
                        .scaleEffect(animateDroplet ? 0.8 : 1.0)
                        .animation(
                            .easeInOut(duration: 1.5)
                            .delay(Double(index) * 0.2)
                            .repeatForever(autoreverses: true),
                            value: animateDroplet
                        )
                }
                
                // Main droplet with checkmark
                ZStack {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(DesignKit.primary.opacity(0.8))
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                }
                .scaleEffect(animateDroplet ? 1.1 : 1.0)
                .animation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                    value: animateDroplet
                )
            }
            .frame(height: 100)
            
            // Success message
            Text(message)
                .title2()
                .foregroundStyle(.primary)
            
            Text(timestamp)
                .caption()
                .foregroundStyle(.secondary)
            
            // Large value display
            VStack(spacing: Spacing.xs) {
                HStack(alignment: .firstTextBaseline) {
                    Text(value)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                    
                    Text(unit)
                        .title3()
                        .foregroundStyle(.secondary)
                }
                
                Text(status)
                    .subheadline()
                    .foregroundStyle(.orange)
            }
            
            // Action buttons
            HStack(spacing: Spacing.md) {
                Button("Before meal") {}
                    .buttonStyle(.bordered)
                    .tint(DesignKit.primary)

                Button("10 Insulin units") {}
                    .buttonStyle(.borderedProminent)
                    .tint(DesignKit.primary)
            }
        }
        .padding(Spacing.lg)
        .onAppear {
            animateDroplet = true
        }
    }
}


#Preview {
    SuccessNotification(
        message: "Success",
        timestamp: "12:23am",
        value: "1234",
        unit: "1234", status: "online"
    )
}
