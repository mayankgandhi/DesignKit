//
//  ColorConfiguration.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

/// Configuration for brand colors, semantic colors, and backgrounds
public struct ColorConfiguration {
    // MARK: - Base Colors
    
    public let absoluteBlack: Color
    public let absoluteWhite: Color
    public let surfaceDark: Color
    public let surfaceLight: Color
    
    // MARK: - Primary Brand Colors
    
    public let primary: Color
    public let primaryDark: Color
    public let accent: Color
    
    // MARK: - Semantic Actions
    
    public let success: Color
    public let warning: Color
    public let danger: Color
    
    // MARK: - Alarm States
    
    public let scheduled: Color
    public let running: Color
    public let paused: Color
    public let alerting: Color
    public let disabled: Color
    
    public init(
        absoluteBlack: Color = Color(red: 0.0, green: 0.0, blue: 0.0),
        absoluteWhite: Color = Color(red: 1.0, green: 1.0, blue: 1.0),
        surfaceDark: Color = Color(red: 0.11, green: 0.11, blue: 0.12),
        surfaceLight: Color = Color(red: 0.96, green: 0.96, blue: 0.97),
        primary: Color,
        primaryDark: Color,
        accent: Color,
        success: Color,
        warning: Color,
        danger: Color,
        scheduled: Color,
        running: Color,
        paused: Color,
        alerting: Color,
        disabled: Color = Color(red: 0.584, green: 0.584, blue: 0.596)
    ) {
        self.absoluteBlack = absoluteBlack
        self.absoluteWhite = absoluteWhite
        self.surfaceDark = surfaceDark
        self.surfaceLight = surfaceLight
        self.primary = primary
        self.primaryDark = primaryDark
        self.accent = accent
        self.success = success
        self.warning = warning
        self.danger = danger
        self.scheduled = scheduled
        self.running = running
        self.paused = paused
        self.alerting = alerting
        self.disabled = disabled
    }
}
