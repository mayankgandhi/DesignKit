import SwiftUI
import DesignKit

struct SpacingExampleView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: DesignKit.xl) {
                // Core Spacing
                sectionView(title: "Core Spacing (8-point system)") {
                    VStack(spacing: DesignKit.md) {
                        spacingRow(name: "XXS", value: DesignKit.xxs, description: "4pt - Micro spacing")
                        spacingRow(name: "XS", value: DesignKit.xs, description: "8pt - Tiny spacing")
                        spacingRow(name: "SM", value: DesignKit.sm, description: "12pt - Small spacing")
                        spacingRow(name: "MD", value: DesignKit.md, description: "16pt - Base unit")
                        spacingRow(name: "LG", value: DesignKit.lg, description: "24pt - Medium-large spacing")
                        spacingRow(name: "XL", value: DesignKit.xl, description: "32pt - Large spacing")
                        spacingRow(name: "XXL", value: DesignKit.xxl, description: "48pt - Extra large spacing")
                        spacingRow(name: "XXXL", value: DesignKit.xxxl, description: "64pt - Section breaks")
                    }
                }

                // Component Spacing
                sectionView(title: "Component Spacing") {
                    VStack(spacing: DesignKit.md) {
                        spacingRow(
                            name: "Tap Target Min",
                            value: DesignKit.tapTargetMin,
                            description: "44pt - Minimum tap target"
                        )
                        spacingRow(
                            name: "Tap Target Preferred",
                            value: DesignKit.tapTargetPreferred,
                            description: "56pt - Preferred tap target"
                        )
                        spacingRow(
                            name: "Button Height Large",
                            value: DesignKit.buttonHeightLarge,
                            description: "64pt - Large button height"
                        )
                        spacingRow(
                            name: "Button Height Standard",
                            value: DesignKit.buttonHeightStandard,
                            description: "48pt - Standard button height"
                        )
                    }
                }

                // Visual Examples
                sectionView(title: "Visual Examples") {
                    VStack(spacing: DesignKit.md) {
                        visualExample(spacing: DesignKit.xxs, name: "XXS (4pt)")
                        visualExample(spacing: DesignKit.xs, name: "XS (8pt)")
                        visualExample(spacing: DesignKit.sm, name: "SM (12pt)")
                        visualExample(spacing: DesignKit.md, name: "MD (16pt)")
                        visualExample(spacing: DesignKit.lg, name: "LG (24pt)")
                    }
                }

                // Padding Example
                sectionView(title: "Padding Example") {
                    VStack(spacing: DesignKit.lg) {
                        paddingExample(padding: DesignKit.sm, name: "SM Padding")
                        paddingExample(padding: DesignKit.md, name: "MD Padding")
                        paddingExample(padding: DesignKit.lg, name: "LG Padding")
                    }
                }
            }
            .padding(DesignKit.lg)
        }
        .background(DesignKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Spacing")
        .navigationBarTitleDisplayMode(.large)
    }

    private func sectionView<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: DesignKit.md) {
            Text(title)
                .headline()
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            content()
        }
        .padding(DesignKit.lg)
        .card()
    }

    private func spacingRow(name: String, value: CGFloat, description: String) -> some View {
        HStack(spacing: DesignKit.md) {
            // Visual indicator
            RoundedRectangle(cornerRadius: DesignKit.radiusTight)
                .fill(DesignKit.primary)
                .frame(width: value, height: 8)

            VStack(alignment: .leading, spacing: DesignKit.xxs) {
                Text(name)
                    .buttonText()
                    .foregroundColor(DesignKit.textPrimary(for: colorScheme))

                Text(description)
                    .caption()
                    .foregroundColor(DesignKit.textSecondary(for: colorScheme))
            }

            Spacer()
        }
    }

    private func visualExample(spacing: CGFloat, name: String) -> some View {
        VStack(alignment: .leading, spacing: DesignKit.xxs) {
            Text(name)
                .caption()
                .foregroundColor(DesignKit.textSecondary(for: colorScheme))

            VStack(spacing: spacing) {
                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: DesignKit.radiusSmall)
                        .fill(DesignKit.primary.opacity(0.3))
                        .frame(height: 30)
                }
            }
        }
    }

    private func paddingExample(padding: CGFloat, name: String) -> some View {
        VStack(alignment: .leading, spacing: DesignKit.xxs) {
            Text(name)
                .caption()
                .foregroundColor(DesignKit.textSecondary(for: colorScheme))

            ZStack {
                RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                    .stroke(DesignKit.primary.opacity(0.3), lineWidth: 2)

                RoundedRectangle(cornerRadius: DesignKit.radiusSmall)
                    .fill(DesignKit.primary.opacity(0.2))
                    .padding(padding)
            }
            .frame(height: 80)
        }
    }
}

#Preview {
    NavigationStack {
        SpacingExampleView()
    }
}
