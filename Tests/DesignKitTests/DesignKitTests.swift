//
//  DesignKitTests.swift
//  DesignKitTests
//
//  Created on 2025.
//

import XCTest
@testable import DesignKit

final class DesignKitTests: XCTestCase {
    func testDesignKitVersion() {
        XCTAssertEqual(DesignKit.version, "1.0.0")
    }
    
    func testSpacingValues() {
        XCTAssertEqual(Spacing.xs, 4)
        XCTAssertEqual(Spacing.sm, 8)
        XCTAssertEqual(Spacing.md, 16)
        XCTAssertEqual(Spacing.lg, 24)
        XCTAssertEqual(Spacing.xl, 32)
        XCTAssertEqual(Spacing.xxl, 48)
    }
}

