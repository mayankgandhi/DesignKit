//
//  AIGeneratorSheet.swift
//  DesignKit
//
//  Created by Mayank Gandhi on 13/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// Bottom sheet for AI-powered text generation
/// Displays a prompt input field and dynamically generated suggestions
public struct AIGeneratorSheet: View {
    // MARK: - Bindings
    @Binding private var isPresented: Bool

    // MARK: - State
    @State private var prompt: String = ""
    @State private var suggestions: [String] = []
    @State private var isGenerating: Bool = false
    @State private var errorMessage: String?
    @FocusState private var isPromptFocused: Bool
    @State private var debounceTask: Task<Void, Never>?

    // MARK: - Dependencies
    private let fieldName: String
    private let service: AIGenerationService
    private let onSelectSuggestion: (String) -> Void

    // MARK: - Initialization
    public init(
        isPresented: Binding<Bool>,
        fieldName: String = "Text",
        service: AIGenerationService = MockAIGenerationService(),
        onSelectSuggestion: @escaping (String) -> Void
    ) {
        self._isPresented = isPresented
        self.fieldName = fieldName
        self.service = service
        self.onSelectSuggestion = onSelectSuggestion
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: DesignKit.lg) {
            // Header
            headerView

            // Prompt input
            promptInputView

            // Suggestions label
            if !suggestions.isEmpty || isGenerating {
                Text("AI Suggestions")
                    .caption()
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
            }

            // Suggestions list
            suggestionsView

            Spacer()
        }
        .padding(DesignKit.lg)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .onAppear {
            // Auto-focus prompt field with slight delay for sheet animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isPromptFocused = true
            }
        }
        .onDisappear {
            // Cancel any pending generation task
            debounceTask?.cancel()
        }
    }

    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Image(systemName: "sparkles")
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.36, green: 0.36, blue: 1.0),
                            Color(red: 0.61, green: 0.35, blue: 0.71),
                            Color(red: 0.0, green: 0.48, blue: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Text("Generate \(fieldName)")
                .headline()

            Spacer()

            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.secondary)
            }
            .accessibilityLabel("Close AI assistant")
            .accessibilityAddTraits(.isButton)
        }
    }

    // MARK: - Prompt Input View
    private var promptInputView: some View {
        VStack(alignment: .leading, spacing: DesignKit.xs) {
            TextField("What would you like to generate?", text: $prompt, axis: .vertical)
                .body()
                .focused($isPromptFocused)
                .lineLimit(2...4)
                .padding(DesignKit.md)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(DesignKit.radiusMedium)
                .overlay(
                    RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .onChange(of: prompt) { _, newValue in
                    handlePromptChange(newValue)
                }
                .submitLabel(.done)
                .accessibilityLabel("AI prompt input")
                .accessibilityHint("Describe what text you want the AI to generate")

            // Error message display
            if let error = errorMessage, !error.isEmpty {
                HStack(spacing: DesignKit.xs) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .caption()
                        .foregroundStyle(.orange)

                    Text(error)
                        .caption()
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, DesignKit.md)
                .padding(.vertical, DesignKit.sm)
                .background(Color(.systemOrange).opacity(0.1))
                .cornerRadius(DesignKit.radiusSmall)
                .transition(.opacity.combined(with: .scale))
            }
        }
    }

    // MARK: - Suggestions View
    private var suggestionsView: some View {
        ScrollView {
            if isGenerating && suggestions.isEmpty {
                // Loading state
                VStack(spacing: DesignKit.md) {
                    ProgressView()
                        .accessibilityLabel("Generating suggestions")
                        .accessibilityValue("Please wait")

                    Text("Generating suggestions...")
                        .footnote()
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(DesignKit.lg)
            } else if !suggestions.isEmpty {
                // Suggestion cards
                VStack(alignment: .leading, spacing: DesignKit.sm) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        suggestionCard(suggestion)
                    }
                }
            } else if !prompt.isEmpty && !isGenerating {
                // Empty state after generation
                Text("No suggestions found. Try a different prompt.")
                    .footnote()
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(DesignKit.lg)
            }
        }
    }

    // MARK: - Suggestion Card
    private func suggestionCard(_ suggestion: String) -> some View {
        Button {
            withAnimation(DesignKit.animationStandard) {
                onSelectSuggestion(suggestion)
                isPresented = false
            }
        } label: {
            HStack {
                Text(suggestion)
                    .body()
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Spacer()

                Image(systemName: "arrow.up.left")
                    .caption()
                    .foregroundStyle(.secondary)
            }
            .padding(DesignKit.md)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(DesignKit.radiusMedium)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Use suggestion: \(suggestion)")
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Prompt Change Handler
    private func handlePromptChange(_ newValue: String) {
        // Cancel previous task
        debounceTask?.cancel()

        // Clear error
        errorMessage = nil

        // Don't generate for empty prompts
        guard !newValue.trimmingCharacters(in: .whitespaces).isEmpty else {
            suggestions = []
            return
        }

        // Create new debounced task
        debounceTask = Task {
            do {
                // Wait 0.5 seconds before generating
                try await Task.sleep(nanoseconds: 500_000_000)

                // Check if task was cancelled
                guard !Task.isCancelled else { return }

                // Generate suggestions
                await generateSuggestions(for: newValue)
            } catch {
                // Task cancelled or sleep interrupted
            }
        }
    }

    // MARK: - Generate Suggestions
    private func generateSuggestions(for promptText: String) async {
        await MainActor.run {
            isGenerating = true
            errorMessage = nil
        }

        do {
            let results = try await service.generateSuggestions(for: promptText)

            // Verify prompt hasn't changed
            guard self.prompt == promptText else { return }

            await MainActor.run {
                withAnimation(DesignKit.animationStandard) {
                    suggestions = results

                    // Show message if no results
                    if results.isEmpty {
                        errorMessage = "No suggestions found. Try a different prompt."
                    }
                }
                isGenerating = false
            }
        } catch AIGenerationError.emptyPrompt {
            await MainActor.run {
                errorMessage = "Please enter a prompt to get suggestions"
                isGenerating = false
            }
        } catch AIGenerationError.rateLimitExceeded {
            await MainActor.run {
                errorMessage = "Too many requests. Please wait a moment."
                isGenerating = false
            }
        } catch {
            await MainActor.run {
                errorMessage = "Failed to generate suggestions. Please try again."
                isGenerating = false
            }
        }
    }
}

// MARK: - Previews
#Preview("Empty Sheet") {
    AIGeneratorSheet(
        isPresented: .constant(true),
        fieldName: "Product Name",
        onSelectSuggestion: { _ in }
    )
}

#Preview("With Prompt") {
    struct PreviewWrapper: View {
        @State private var isPresented = true

        var body: some View {
            AIGeneratorSheet(
                isPresented: $isPresented,
                fieldName: "Description",
                onSelectSuggestion: { suggestion in
                    print("Selected: \(suggestion)")
                }
            )
        }
    }

    return PreviewWrapper()
}
