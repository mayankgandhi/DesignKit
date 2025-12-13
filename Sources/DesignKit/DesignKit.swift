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
    public let version = "1.0.3"

    // MARK: - Internal State Management

    var configuration: DesignKitConfiguration

    public init(_ configuration: DesignKitConfiguration) {
        self.configuration = configuration
    }

    // MARK: - Shared Instance

    public static var current = DesignKit(.default)

}
