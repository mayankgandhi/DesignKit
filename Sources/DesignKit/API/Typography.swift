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
    static func largeTitle() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 34, relativeTo: .largeTitle)
        }
        return .system(.largeTitle, design: DesignKit.current.configuration.typography.fontDesign, weight: .bold)
    }

    /// Title 1 style
    static func title() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 28, relativeTo: .title)
        }
        return .system(.title, design: DesignKit.current.configuration.typography.fontDesign, weight: .bold)
    }

    /// Title 2 style
    static func title2() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 22, relativeTo: .title2)
        }
        return .system(.title2, design: DesignKit.current.configuration.typography.fontDesign, weight: .bold)
    }

    /// Title 3 style
    static func title3() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 20, relativeTo: .title3)
        }
        return .system(.title3, design: DesignKit.current.configuration.typography.fontDesign, weight: .semibold)
    }

    /// Headline style
    static func headline() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 17, relativeTo: .headline)
        }
        return .system(.headline, design: DesignKit.current.configuration.typography.fontDesign, weight: .semibold)
    }

    /// Body style
    static func body() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 17, relativeTo: .body)
        }
        return .system(.body, design: DesignKit.current.configuration.typography.fontDesign, weight: .regular)
    }

    /// Callout style
    static func callout() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 16, relativeTo: .callout)
        }
        return .system(.callout, design: DesignKit.current.configuration.typography.fontDesign, weight: .regular)
    }

    /// Subheadline style
    static func subheadline() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 15, relativeTo: .subheadline)
        }
        return .system(.subheadline, design: DesignKit.current.configuration.typography.fontDesign, weight: .semibold)
    }

    /// Footnote style
    static func footnote() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 13, relativeTo: .footnote)
        }
        return .system(.footnote, design: DesignKit.current.configuration.typography.fontDesign, weight: .medium)
    }

    /// Caption 1 style
    static func caption() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 12, relativeTo: .caption)
        }
        return .system(.caption, design: DesignKit.current.configuration.typography.fontDesign, weight: .medium)
    }

    /// Caption 2 style
    static func caption2() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 11, relativeTo: .caption2)
        }
        return .system(.caption2, design: DesignKit.current.configuration.typography.fontDesign, weight: .regular)
    }
    
    // MARK: - Custom Typography Styles

    /// Time display font (28pt) - for card time displays
    static func timeDisplay() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 28, relativeTo: .title)
        }
        return .system(size: 28, weight: .bold, design: DesignKit.current.configuration.typography.fontDesign)
    }

    /// Ticker title font (18pt) - for ticker names
    static func tickerTitle() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 18, relativeTo: .headline)
        }
        return .system(size: 18, weight: .semibold, design: DesignKit.current.configuration.typography.fontDesign)
    }

    /// Detail text font (15pt) - for schedule details
    static func detailText() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 15, relativeTo: .subheadline)
        }
        return .system(size: 15, weight: .medium, design: DesignKit.current.configuration.typography.fontDesign)
    }

    /// Button text font (14pt) - for buttons and labels
    static func buttonText() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 14, relativeTo: .subheadline)
        }
        return .system(size: 14, weight: .semibold, design: DesignKit.current.configuration.typography.fontDesign)
    }

    /// Small text font (12pt) - for secondary info
    static func smallText() -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: 12, relativeTo: .caption)
        }
        return .system(size: 12, weight: .medium, design: DesignKit.current.configuration.typography.fontDesign)
    }

    // MARK: - Custom Size Helper

    /// Creates a font with custom size that respects the configured font family
    /// - Parameters:
    ///   - size: The point size of the font
    ///   - weight: The weight of the font (only used when fontFamily is not configured)
    ///   - relativeTo: The text style to scale relative to for Dynamic Type support
    /// - Returns: A Font configured with either the custom font family or system font with design
    static func customSize(_ size: CGFloat, weight: Font.Weight = .regular, relativeTo: Font.TextStyle = .body) -> Font {
        if let fontFamily = DesignKit.current.configuration.typography.fontFamily {
            return .custom(fontFamily, size: size, relativeTo: relativeTo)
        }
        return .system(size: size, weight: weight, design: DesignKit.current.configuration.typography.fontDesign)
    }
}

// MARK: - View Extensions for Typography

public extension View {
    
    /// Apply SF Pro Rounded large title style
    func largeTitle() -> some View {
        self.font(DesignKit.largeTitle())
    }
    
    /// Apply SF Pro Rounded title style
    func title() -> some View {
        self.font(DesignKit.title())
    }
    
    /// Apply SF Pro Rounded title 2 style
    func title2() -> some View {
        self.font(DesignKit.title2())
    }
    
    /// Apply SF Pro Rounded title 3 style
    func title3() -> some View {
        self.font(DesignKit.title3())
    }
    
    /// Apply SF Pro Rounded headline style
    func headline() -> some View {
        self.font(DesignKit.headline())
    }
    
    /// Apply SF Pro Rounded body style
    func body() -> some View {
        self.font(DesignKit.body())
    }
    
    /// Apply SF Pro Rounded callout style
    func callout() -> some View {
        self.font(DesignKit.callout())
    }
    
    /// Apply SF Pro Rounded subheadline style
    func subheadline() -> some View {
        self.font(DesignKit.subheadline())
    }
    
    /// Apply SF Pro Rounded footnote style
    func footnote() -> some View {
        self.font(DesignKit.footnote())
    }
    
    /// Apply SF Pro Rounded caption style
    func caption() -> some View {
        self.font(DesignKit.caption())
    }
    
    /// Apply SF Pro Rounded caption 2 style
    func caption2() -> some View {
        self.font(DesignKit.caption2())
    }
    
    // MARK: - Custom Typography Styles
    
    /// Apply consistent time display font (28pt) - for card time displays
    func timeDisplay() -> some View {
        self.font(DesignKit.timeDisplay())
    }
    
    /// Apply consistent ticker title font (18pt) - for ticker names
    func tickerTitle() -> some View {
        self.font(DesignKit.tickerTitle())
    }
    
    /// Apply consistent detail text font (15pt) - for schedule details
    func detailText() -> some View {
        self.font(DesignKit.detailText())
    }
    
    /// Apply consistent button text font (14pt) - for buttons and labels
    func buttonText() -> some View {
        self.font(DesignKit.buttonText())
    }
    
    /// Apply consistent small text font (12pt) - for secondary info
    func smallText() -> some View {
        self.font(DesignKit.smallText())
    }
}
