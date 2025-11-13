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
        .system(.largeTitle, design: current.typography.fontDesign, weight: .bold)
    }
    
    /// Title 1 style
    static func title() -> Font {
        .system(.title, design: current.typography.fontDesign, weight: .bold)
    }
    
    /// Title 2 style
    static func title2() -> Font {
        .system(.title2, design: current.typography.fontDesign, weight: .bold)
    }
    
    /// Title 3 style
    static func title3() -> Font {
        .system(.title3, design: current.typography.fontDesign, weight: .semibold)
    }
    
    /// Headline style
    static func headline() -> Font {
        .system(.headline, design: current.typography.fontDesign, weight: .semibold)
    }
    
    /// Body style
    static func body() -> Font {
        .system(.body, design: current.typography.fontDesign, weight: .regular)
    }
    
    /// Callout style
    static func callout() -> Font {
        .system(.callout, design: current.typography.fontDesign, weight: .regular)
    }
    
    /// Subheadline style
    static func subheadline() -> Font {
        .system(.subheadline, design: current.typography.fontDesign, weight: .semibold)
    }
    
    /// Footnote style
    static func footnote() -> Font {
        .system(.footnote, design: current.typography.fontDesign, weight: .medium)
    }
    
    /// Caption 1 style
    static func caption() -> Font {
        .system(.caption, design: current.typography.fontDesign, weight: .medium)
    }
    
    /// Caption 2 style
    static func caption2() -> Font {
        .system(.caption2, design: current.typography.fontDesign, weight: .regular)
    }
    
    // MARK: - Custom Typography Styles
    
    /// Time display font (28pt) - for card time displays
    static func timeDisplay() -> Font {
        .system(size: 28, weight: .bold, design: current.typography.fontDesign)
    }
    
    /// Ticker title font (18pt) - for ticker names
    static func tickerTitle() -> Font {
        .system(size: 18, weight: .semibold, design: current.typography.fontDesign)
    }
    
    /// Detail text font (15pt) - for schedule details
    static func detailText() -> Font {
        .system(size: 15, weight: .medium, design: current.typography.fontDesign)
    }
    
    /// Button text font (14pt) - for buttons and labels
    static func buttonText() -> Font {
        .system(size: 14, weight: .semibold, design: current.typography.fontDesign)
    }
    
    /// Small text font (12pt) - for secondary info
    static func smallText() -> Font {
        .system(size: 12, weight: .medium, design: current.typography.fontDesign)
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
