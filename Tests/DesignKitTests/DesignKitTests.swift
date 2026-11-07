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
        // `version` is an instance member, so it is read off a configured instance.
        let designKit = DesignKit(.default)
        // Asserting the shape rather than a literal: a pinned version string has to be
        // edited on every release, and the promise worth testing is that `version`
        // reports a well-formed MAJOR.MINOR.PATCH, not which release it happens to be.
        let components = designKit.version.split(separator: ".", omittingEmptySubsequences: false)
        XCTAssertEqual(
            components.count, 3,
            "version should have three dot-separated components, got \(designKit.version)"
        )
        XCTAssertTrue(
            components.allSatisfy { UInt($0) != nil },
            "every version component should be a non-negative integer, got \(designKit.version)"
        )
    }

    func testSpacingValues() {
        XCTAssertEqual(Spacing.xxs, 4)
        XCTAssertEqual(Spacing.xs, 8)
        XCTAssertEqual(Spacing.sm, 12)
        XCTAssertEqual(Spacing.md, 16)
        XCTAssertEqual(Spacing.lg, 24)
        XCTAssertEqual(Spacing.xl, 32)
        XCTAssertEqual(Spacing.xxl, 48)
        XCTAssertEqual(Spacing.xxxl, 64)
    }
}

