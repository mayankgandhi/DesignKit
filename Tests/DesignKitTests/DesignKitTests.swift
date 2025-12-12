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
        XCTAssertEqual(DesignKit.version, "1.0.2")
    }

    func testSpacingValues() {
        XCTAssertEqual(DesignKit.xxs, 4)
        XCTAssertEqual(DesignKit.xs, 8)
        XCTAssertEqual(DesignKit.sm, 12)
        XCTAssertEqual(DesignKit.md, 16)
        XCTAssertEqual(DesignKit.lg, 24)
        XCTAssertEqual(DesignKit.xl, 32)
        XCTAssertEqual(DesignKit.xxl, 48)
        XCTAssertEqual(DesignKit.xxxl, 64)
    }
}

