//
//  AddProductView.swift
//  DesignKitExample
//
//  Created by Mayank Gandhi on 13/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI
import DesignKit

struct AddProductView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let designKit: DesignKit

    // Form state
    @State private var productName: String = ""
    @State private var productDescription: String = ""
    @State private var price: String = ""
    @State private var showSuccessAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                headerSection

                formSection

                actionButtons
            }
            .padding(Spacing.lg)
        }
        .background(designKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Add Product")
        .navigationBarTitleDisplayMode(.large)
        .alert("Product Saved", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your product has been added successfully!")
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.system(size: 24))
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

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("AI-Assisted Product Entry")
                        .headline(designKit)

                    Text("Use AI to generate product names and descriptions")
                        .footnote(designKit)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.lg)
        .card(designKit: designKit)
    }

    private var formSection: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Section title
            Text("Product Information")
                .subheadline(designKit)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            // AI-enabled text fields
            AISmartTextField(
                text: $productName,
                placeholder: "e.g., Organic Green Tea",
                axis: .horizontal,
                helperText: "Tap the sparkle icon to generate suggestions",
                icon: "cube.box.fill",
                iconColor: designKit.primary,
                designKit: designKit
            )

            AISmartTextField(
                text: $productDescription,
                placeholder: "Enter product description...",
                axis: .vertical,
                helperText: "Describe your product or let AI help you",
                icon: "text.alignleft",
                iconColor: .blue,
                designKit: designKit
            )

            // Regular text field for price
            TextFieldItem(
                icon: "dollarsign.circle.fill",
                title: "Price",
                text: $price,
                placeholder: "0.00",
                helperText: "Enter product price in USD",
                iconColor: .green,
                designKit: designKit,
                keyboardType: .decimalPad
            )
        }
        .padding(Spacing.lg)
        .card(designKit: designKit)
    }

    private var actionButtons: some View {
        VStack(spacing: Spacing.md) {
            DSButton("Save Product", style: .primary, icon: "checkmark.circle.fill", designKit: designKit) {
                saveProduct()
            }

            DSButton("Clear Form", style: .secondary, icon: "arrow.counterclockwise", designKit: designKit) {
                clearForm()
            }
        }
        .padding(Spacing.lg)
    }

    // MARK: - Actions
    private func saveProduct() {
        // Validate required fields
        guard !productName.isEmpty else { return }

        // Show success alert
        showSuccessAlert = true
    }

    private func clearForm() {
        productName = ""
        productDescription = ""
        price = ""
    }
}
