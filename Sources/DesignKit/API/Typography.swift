//
//  Typography.swift
//  DesignKit
//
//  Created on 2025.
//

import SwiftUI

// MARK: - Flat Typography API

public extension DesignKit {

    /// Large Title style
    func largeTitle() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 34, relativeTo: .largeTitle)
        }
        return .system(.largeTitle, design: configuration.typography.fontDesign, weight: .bold)
    }

    /// Title 1 style
    func title() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 28, relativeTo: .title)
        }
        return .system(.title, design: configuration.typography.fontDesign, weight: .bold)
    }

    /// Title 2 style
    func title2() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 22, relativeTo: .title2)
        }
        return .system(.title2, design: configuration.typography.fontDesign, weight: .bold)
    }

    /// Title 3 style
    func title3() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 20, relativeTo: .title3)
        }
        return .system(.title3, design: configuration.typography.fontDesign, weight: .semibold)
    }

    /// Headline style
    func headline() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 17, relativeTo: .headline)
        }
        return .system(.headline, design: configuration.typography.fontDesign, weight: .semibold)
    }

    /// Body style
    func body() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 17, relativeTo: .body)
        }
        return .system(.body, design: configuration.typography.fontDesign, weight: .regular)
    }

    /// Callout style
    func callout() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 16, relativeTo: .callout)
        }
        return .system(.callout, design: configuration.typography.fontDesign, weight: .regular)
    }

    /// Subheadline style
    func subheadline() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 15, relativeTo: .subheadline)
        }
        return .system(.subheadline, design: configuration.typography.fontDesign, weight: .semibold)
    }

    /// Footnote style
    func footnote() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 13, relativeTo: .footnote)
        }
        return .system(.footnote, design: configuration.typography.fontDesign, weight: .medium)
    }

    /// Caption 1 style
    func caption() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 12, relativeTo: .caption)
        }
        return .system(.caption, design: configuration.typography.fontDesign, weight: .medium)
    }

    /// Caption 2 style
    func caption2() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 11, relativeTo: .caption2)
        }
        return .system(.caption2, design: configuration.typography.fontDesign, weight: .regular)
    }
    
    // MARK: - Custom Typography Styles

    /// Time display font (28pt) - for card time displays
    func timeDisplay() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 28, relativeTo: .title)
        }
        return .system(size: 28, weight: .bold, design: configuration.typography.fontDesign)
    }

    /// Ticker title font (18pt) - for ticker names
    func tickerTitle() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 18, relativeTo: .headline)
        }
        return .system(size: 18, weight: .semibold, design: configuration.typography.fontDesign)
    }

    /// Detail text font (15pt) - for schedule details
    func detailText() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 15, relativeTo: .subheadline)
        }
        return .system(size: 15, weight: .medium, design: configuration.typography.fontDesign)
    }

    /// Button text font (14pt) - for buttons and labels
    func buttonText() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 14, relativeTo: .subheadline)
        }
        return .system(size: 14, weight: .semibold, design: configuration.typography.fontDesign)
    }

    /// Small text font (12pt) - for secondary info
    func smallText() -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: 12, relativeTo: .caption)
        }
        return .system(size: 12, weight: .medium, design: configuration.typography.fontDesign)
    }

    // MARK: - Custom Size Helper

    /// Creates a font with custom size that respects the configured font family
    /// - Parameters:
    ///   - size: The point size of the font
    ///   - weight: The weight of the font (only used when fontFamily is not configured)
    ///   - relativeTo: The text style to scale relative to for Dynamic Type support
    /// - Returns: A Font configured with either the custom font family or system font with design
    func customSize(_ size: CGFloat, weight: Font.Weight = .regular, relativeTo: Font.TextStyle = .body) -> Font {
        if let fontFamily = configuration.typography.fontFamily {
            return .custom(fontFamily, size: size, relativeTo: relativeTo)
        }
        return .system(size: size, weight: weight, design: configuration.typography.fontDesign)
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
