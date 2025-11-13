//
//  TypographyConfiguration.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

/// Configuration for typography (font family, type scale)
public struct TypographyConfiguration {
    public let fontDesign: Font.Design
    public let fontFamily: String?
    
    public init(
        fontDesign: Font.Design = .rounded,
        fontFamily: String? = nil
    ) {
        self.fontDesign = fontDesign
        self.fontFamily = fontFamily
    }
}
