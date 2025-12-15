//
//  ImageUploadService.swift
//  DesignKit
//
//  Created by Mayank Gandhi on 15/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

/// Protocol for image upload services
/// Allows mock implementation now, real API integration later
public protocol ImageUploadService {
    /// Uploads an image and returns the URL
    /// - Parameter image: The UIImage to upload
    /// - Returns: URL string of the uploaded image
    /// - Throws: Upload-specific errors
    func uploadImage(_ image: UIImage) async throws -> String
}

/// Error types for image upload
public enum ImageUploadError: LocalizedError {
    case imageConversionFailed
    case networkError(Error)
    case invalidResponse
    case fileSizeTooLarge
    case unsupportedFormat

    public var errorDescription: String? {
        switch self {
        case .imageConversionFailed:
            return "Failed to process image"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        case .fileSizeTooLarge:
            return "Image file is too large"
        case .unsupportedFormat:
            return "Unsupported image format"
        }
    }
}

/// Mock implementation of image upload service
/// Simulates image upload with realistic delays and occasional failures
public class MockImageUploadService: ImageUploadService {

    public init() {}

    public func uploadImage(_ image: UIImage) async throws -> String {
        // Simulate upload delay (2-4 seconds)
        let delay = UInt64(Double.random(in: 2.0...4.0) * 1_000_000_000)
        try await Task.sleep(nanoseconds: delay)

        // Simulate 10% failure rate for testing error handling
        if Double.random(in: 0...1) < 0.1 {
            throw ImageUploadError.networkError(
                NSError(domain: "com.designkit.mock", code: 500, userInfo: [
                    NSLocalizedDescriptionKey: "Connection timeout"
                ])
            )
        }

        // Return mock URL with unique identifier
        return "https://example.com/uploads/\(UUID().uuidString).jpg"
    }
}

#endif
