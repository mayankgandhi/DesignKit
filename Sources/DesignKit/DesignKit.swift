//
//  DesignKit.swift
//  DesignKit
//
//  Created on 2025.
//

import Foundation
import SwiftUI

/// DesignKit - A shared design system framework for cross-app use
public struct DesignKit {
    public static let version = "1.0.0"
    
    // MARK: - Internal State Management
    
    private static var _current: DesignKitConfiguration?
    
    /// Configure DesignKit at app launch (before any views)
    /// - Parameter configuration: The design system configuration
    public static func configure(_ configuration: DesignKitConfiguration) {
        _current = configuration
    }
    
    /// Internal access to current configuration
    internal static var current: DesignKitConfiguration {
        guard let config = _current else {
            fatalError("DesignKit not configured. Call DesignKit.configure() at app launch.")
        }
        return config
    }
    
    public init() {}
}
