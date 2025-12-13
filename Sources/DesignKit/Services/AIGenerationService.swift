//
//  AIGenerationService.swift
//  DesignKit
//
//  Created by Mayank Gandhi on 13/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import Foundation

/// Protocol for AI text generation services
/// Allows mock implementation now, real API integration later
public protocol AIGenerationService {
    /// Generate text suggestions based on a user prompt
    /// - Parameter prompt: The user's input prompt
    /// - Returns: Array of suggestion strings
    /// - Throws: Service-specific errors (network, API limits, etc.)
    func generateSuggestions(for prompt: String) async throws -> [String]
}

/// Error types for AI generation
public enum AIGenerationError: LocalizedError {
    case emptyPrompt
    case networkError(Error)
    case invalidResponse
    case rateLimitExceeded

    public var errorDescription: String? {
        switch self {
        case .emptyPrompt:
            return "Please enter a prompt"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from AI service"
        case .rateLimitExceeded:
            return "Rate limit exceeded, please try again later"
        }
    }
}

/// Mock implementation of AI generation service
/// Simulates AI text generation with realistic delays and context-aware suggestions
public class MockAIGenerationService: AIGenerationService {

    private let suggestionBank: [String: [String]] = [
        "product name": [
            "Premium Organic Green Tea Collection",
            "Artisan Roasted Coffee Beans - Limited Edition",
            "Handcrafted Dark Chocolate Truffles"
        ],
        "product title": [
            "Eco-Friendly Bamboo Utensil Set",
            "Sustainable Cotton Tote Bag",
            "Reusable Stainless Steel Water Bottle"
        ],
        "product description": [
            "Experience the ultimate comfort with premium materials crafted for durability and style. Perfect for everyday use.",
            "Handcrafted with care using sustainable ingredients sourced from local farms. Eco-friendly packaging with zero waste commitment.",
            "The perfect addition to your collection. Features high-quality construction and modern design that stands the test of time."
        ],
        "description": [
            "Designed with precision and attention to detail, this product combines functionality with elegant aesthetics.",
            "Made from premium materials that ensure long-lasting performance and timeless appeal.",
            "A versatile choice that seamlessly integrates into your daily routine while delivering exceptional results."
        ],
        "tea": [
            "Premium Japanese Matcha - Ceremonial Grade",
            "Organic Earl Grey with Lavender",
            "Chamomile & Honey Herbal Blend"
        ],
        "coffee": [
            "Single-Origin Ethiopian Yirgacheffe",
            "French Roast Dark Blend",
            "Vanilla Hazelnut Medium Roast"
        ],
        "leather": [
            "Vintage Leather Messenger Bag",
            "Handcrafted Leather Wallet - Full Grain",
            "Premium Leather Laptop Sleeve"
        ],
        "jacket": [
            "Classic Denim Jacket - Vintage Wash",
            "Waterproof Rain Jacket with Hood",
            "Quilted Puffer Jacket - Winter Collection"
        ]
    ]

    public init() {}

    public func generateSuggestions(for prompt: String) async throws -> [String] {
        // Validate prompt
        guard !prompt.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw AIGenerationError.emptyPrompt
        }

        // Simulate network delay (1-2 seconds)
        let delay = UInt64(Double.random(in: 1.0...2.0) * 1_000_000_000)
        try await Task.sleep(nanoseconds: delay)

        // Match prompt to suggestion category
        let lowercasedPrompt = prompt.lowercased()

        // Try to find matching suggestions
        for (key, suggestions) in suggestionBank {
            if lowercasedPrompt.contains(key) {
                return suggestions
            }
        }

        // If no specific match, generate generic suggestions based on prompt
        return [
            "Premium \(prompt) - Limited Edition",
            "Handcrafted \(prompt) with Modern Design",
            "\(prompt) | Best Seller Collection"
        ]
    }
}
