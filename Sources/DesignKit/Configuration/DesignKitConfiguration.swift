//
//  DesignKitConfiguration.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

/// Complete design system configuration combining colors and typography
public struct DesignKitConfiguration {
    public let colors: ColorConfiguration
    public let typography: TypographyConfiguration

    public init(
        colors: ColorConfiguration,
        typography: TypographyConfiguration
    ) {
        self.colors = colors
        self.typography = typography
    }

    public static let `default` = DesignKitConfiguration(
        colors: ColorConfiguration(
            primary: Color.blue,
            primaryDark: Color(red: 0.0, green: 0.38, blue: 0.8),
            accent: Color.orange,
            success: Color.green,
            warning: Color.yellow,
            danger: Color.red,
            scheduled: Color.blue,
            running: Color.green,
            paused: Color.yellow,
            alerting: Color.red
        ),
        typography: TypographyConfiguration(fontDesign: .rounded)
    )
}
