//
//  TypographyConfiguration.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

/// Font weight variants for custom fonts
/// Maps font weights to their specific font family names
/// Example: FontWeightVariants(regular: "PlusJakartaSans-Regular", semibold: "PlusJakartaSans-SemiBold", bold: "PlusJakartaSans-Bold")
public struct FontWeightVariants {
    public let regular: String
    public let medium: String
    public let semibold: String
    public let bold: String

    public init(
        regular: String,
        medium: String? = nil,
        semibold: String? = nil,
        bold: String? = nil
    ) {
        self.regular = regular
        self.medium = medium ?? regular
        self.semibold = semibold ?? regular
        self.bold = bold ?? regular
    }

    /// Get the font name for a specific weight
    func fontName(for weight: Font.Weight) -> String {
        switch weight {
        case .bold, .heavy, .black:
            return bold
        case .semibold:
            return semibold
        case .medium:
            return medium
        default:
            return regular
        }
    }
}

/// Configuration for typography (font family, type scale)
public struct TypographyConfiguration {
    public let fontDesign: Font.Design
    public let fontFamily: String?
    public let fontWeights: FontWeightVariants?

    public init(
        fontDesign: Font.Design = .rounded,
        fontFamily: String? = nil,
        fontWeights: FontWeightVariants? = nil
    ) {
        self.fontDesign = fontDesign
        self.fontFamily = fontFamily
        self.fontWeights = fontWeights
    }
}
