import SwiftUI
import DesignKit

struct SpacingExampleView: View {
    @Environment(\.colorScheme) var colorScheme
    let designKit: DesignKit
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // Core Spacing
                sectionView(title: "Core Spacing (8-point system)") {
                    VStack(spacing: Spacing.md) {
                        spacingRow(name: "XXS", value: Spacing.xxs, description: "4pt - Micro spacing")
                        spacingRow(name: "XS", value: Spacing.xs, description: "8pt - Tiny spacing")
                        spacingRow(name: "SM", value: Spacing.sm, description: "12pt - Small spacing")
                        spacingRow(name: "MD", value: Spacing.md, description: "16pt - Base unit")
                        spacingRow(name: "LG", value: Spacing.lg, description: "24pt - Medium-large spacing")
                        spacingRow(name: "XL", value: Spacing.xl, description: "32pt - Large spacing")
                        spacingRow(name: "XXL", value: Spacing.xxl, description: "48pt - Extra large spacing")
                        spacingRow(name: "XXXL", value: Spacing.xxxl, description: "64pt - Section breaks")
                    }
                }

                // Component Spacing
                sectionView(title: "Component Spacing") {
                    VStack(spacing: Spacing.md) {
                        spacingRow(
                            name: "Tap Target Min",
                            value: Spacing.tapTargetMin,
                            description: "44pt - Minimum tap target"
                        )
                        spacingRow(
                            name: "Tap Target Preferred",
                            value: Spacing.tapTargetPreferred,
                            description: "56pt - Preferred tap target"
                        )
                        spacingRow(
                            name: "Button Height Large",
                            value: Spacing.buttonHeightLarge,
                            description: "64pt - Large button height"
                        )
                        spacingRow(
                            name: "Button Height Standard",
                            value: Spacing.buttonHeightStandard,
                            description: "48pt - Standard button height"
                        )
                    }
                }

                // Visual Examples
                sectionView(title: "Visual Examples") {
                    VStack(spacing: Spacing.md) {
                        visualExample(spacing: Spacing.xxs, name: "XXS (4pt)")
                        visualExample(spacing: Spacing.xs, name: "XS (8pt)")
                        visualExample(spacing: Spacing.sm, name: "SM (12pt)")
                        visualExample(spacing: Spacing.md, name: "MD (16pt)")
                        visualExample(spacing: Spacing.lg, name: "LG (24pt)")
                    }
                }

                // Padding Example
                sectionView(title: "Padding Example") {
                    VStack(spacing: Spacing.lg) {
                        paddingExample(padding: Spacing.sm, name: "SM Padding")
                        paddingExample(padding: Spacing.md, name: "MD Padding")
                        paddingExample(padding: Spacing.lg, name: "LG Padding")
                    }
                }
            }
            .padding(Spacing.lg)
        }
        .background(designKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Spacing")
        .navigationBarTitleDisplayMode(.large)
    }

    private func sectionView<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(title)
                .headline(designKit)
                .foregroundColor(designKit.textPrimary(for: colorScheme))

            content()
        }
        .padding(Spacing.lg)
        .card(designKit: designKit)
    }

    private func spacingRow(name: String, value: CGFloat, description: String) -> some View {
        HStack(spacing: Spacing.md) {
            // Visual indicator
            RoundedRectangle(cornerRadius: Radius.tight)
                .fill(designKit.primary)
                .frame(width: value, height: 8)

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(name)
                    .buttonText(designKit)
                    .foregroundColor(designKit.textPrimary(for: colorScheme))

                Text(description)
                    .caption(designKit)
                    .foregroundColor(designKit.textSecondary(for: colorScheme))
            }

            Spacer()
        }
    }

    private func visualExample(spacing: CGFloat, name: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            Text(name)
                .caption(designKit)
                .foregroundColor(designKit.textSecondary(for: colorScheme))

            VStack(spacing: spacing) {
                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: Radius.small)
                        .fill(designKit.primary.opacity(0.3))
                        .frame(height: 30)
                }
            }
        }
    }

    private func paddingExample(padding: CGFloat, name: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            Text(name)
                .caption(designKit)
                .foregroundColor(designKit.textSecondary(for: colorScheme))

            ZStack {
                RoundedRectangle(cornerRadius: Radius.medium)
                    .stroke(designKit.primary.opacity(0.3), lineWidth: 2)

                RoundedRectangle(cornerRadius: Radius.small)
                    .fill(designKit.primary.opacity(0.2))
                    .padding(padding)
            }
            .frame(height: 80)
        }
    }
}

#Preview {
    NavigationStack {
        SpacingExampleView(designKit: DesignKit(.default))
    }
}
