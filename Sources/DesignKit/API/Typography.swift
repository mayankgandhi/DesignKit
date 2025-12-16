//
//  Typography.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Flat Typography API

public extension DesignKit {

    // MARK: - Private Helper

    /// Creates a font with the specified weight, using custom font variants if configured
    private func font(size: CGFloat, weight: Font.Weight, relativeTo: Font.TextStyle) -> Font {
        if let fontWeights = configuration.typography.fontWeights {
            let fontName = fontWeights.fontName(for: weight)
            return .custom(fontName, size: size, relativeTo: relativeTo)
        } else if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: size, relativeTo: relativeTo)
        }
        return .system(size: size, weight: weight, design: configuration.typography.fontDesign)
    }

    // MARK: - Typography Styles

    /// Large Title style
    func largeTitle() -> Font {
        font(size: 34, weight: .bold, relativeTo: .largeTitle)
    }

    /// Title 1 style
    func title() -> Font {
        font(size: 28, weight: .bold, relativeTo: .title)
    }

    /// Title 2 style
    func title2() -> Font {
        font(size: 22, weight: .bold, relativeTo: .title2)
    }

    /// Title 3 style
    func title3() -> Font {
        font(size: 20, weight: .semibold, relativeTo: .title3)
    }

    /// Headline style
    func headline() -> Font {
        font(size: 17, weight: .semibold, relativeTo: .headline)
    }

    /// Body style
    func body() -> Font {
        font(size: 17, weight: .regular, relativeTo: .body)
    }

    /// Callout style
    func callout() -> Font {
        font(size: 16, weight: .regular, relativeTo: .callout)
    }

    /// Subheadline style
    func subheadline() -> Font {
        font(size: 15, weight: .semibold, relativeTo: .subheadline)
    }

    /// Footnote style
    func footnote() -> Font {
        font(size: 13, weight: .medium, relativeTo: .footnote)
    }

    /// Caption 1 style
    func caption() -> Font {
        font(size: 12, weight: .medium, relativeTo: .caption)
    }

    /// Caption 2 style
    func caption2() -> Font {
        font(size: 11, weight: .regular, relativeTo: .caption2)
    }
    
    // MARK: - Custom Typography Styles

    /// Time display font (28pt) - for card time displays
    func timeDisplay() -> Font {
        font(size: 28, weight: .bold, relativeTo: .title)
    }

    /// Ticker title font (18pt) - for ticker names
    func tickerTitle() -> Font {
        font(size: 18, weight: .semibold, relativeTo: .headline)
    }

    /// Detail text font (15pt) - for schedule details
    func detailText() -> Font {
        font(size: 15, weight: .medium, relativeTo: .subheadline)
    }

    /// Button text font (14pt) - for buttons and labels
    func buttonText() -> Font {
        font(size: 14, weight: .semibold, relativeTo: .subheadline)
    }

    /// Small text font (12pt) - for secondary info
    func smallText() -> Font {
        font(size: 12, weight: .medium, relativeTo: .caption)
    }

    // MARK: - Custom Size Helper

    /// Creates a font with custom size that respects the configured font family and weight variants
    /// - Parameters:
    ///   - size: The point size of the font
    ///   - weight: The weight of the font
    ///   - relativeTo: The text style to scale relative to for Dynamic Type support
    /// - Returns: A Font configured with the appropriate weight variant if available, or fallback to system font
    func customSize(_ size: CGFloat, weight: Font.Weight = .regular, relativeTo: Font.TextStyle = .body) -> Font {
        font(size: size, weight: weight, relativeTo: relativeTo)
    }
}

// MARK: - View Extensions for Typography

public extension View {

    /// Apply large title style with configured font
    func largeTitle(_ designKit: DesignKit) -> some View {
        self.font(designKit.largeTitle())
    }

    /// Apply title style with configured font
    func title(_ designKit: DesignKit) -> some View {
        self.font(designKit.title())
    }

    /// Apply title 2 style with configured font
    func title2(_ designKit: DesignKit) -> some View {
        self.font(designKit.title2())
    }

    /// Apply title 3 style with configured font
    func title3(_ designKit: DesignKit) -> some View {
        self.font(designKit.title3())
    }

    /// Apply headline style with configured font
    func headline(_ designKit: DesignKit) -> some View {
        self.font(designKit.headline())
    }

    /// Apply body style with configured font
    func body(_ designKit: DesignKit) -> some View {
        self.font(designKit.body())
    }

    /// Apply callout style with configured font
    func callout(_ designKit: DesignKit) -> some View {
        self.font(designKit.callout())
    }

    /// Apply subheadline style with configured font
    func subheadline(_ designKit: DesignKit) -> some View {
        self.font(designKit.subheadline())
    }

    /// Apply footnote style with configured font
    func footnote(_ designKit: DesignKit) -> some View {
        self.font(designKit.footnote())
    }

    /// Apply caption style with configured font
    func caption(_ designKit: DesignKit) -> some View {
        self.font(designKit.caption())
    }

    /// Apply caption 2 style with configured font
    func caption2(_ designKit: DesignKit) -> some View {
        self.font(designKit.caption2())
    }

    // MARK: - Custom Typography Styles

    /// Apply consistent time display font (28pt) - for card time displays
    func timeDisplay(_ designKit: DesignKit) -> some View {
        self.font(designKit.timeDisplay())
    }

    /// Apply consistent ticker title font (18pt) - for ticker names
    func tickerTitle(_ designKit: DesignKit) -> some View {
        self.font(designKit.tickerTitle())
    }

    /// Apply consistent detail text font (15pt) - for schedule details
    func detailText(_ designKit: DesignKit) -> some View {
        self.font(designKit.detailText())
    }

    /// Apply consistent button text font (14pt) - for buttons and labels
    func buttonText(_ designKit: DesignKit) -> some View {
        self.font(designKit.buttonText())
    }

    /// Apply consistent small text font (12pt) - for secondary info
    func smallText(_ designKit: DesignKit) -> some View {
        self.font(designKit.smallText())
    }
}
