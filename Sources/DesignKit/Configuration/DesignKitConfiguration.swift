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
}
