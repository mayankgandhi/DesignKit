import SwiftUI
import DesignKit

struct ColorsExampleView: View {
    let designKit: DesignKit
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // Brand Colors
                sectionView(title: "Brand Colors") {
                    colorRow(name: "Primary", color: designKit.primary)
                    colorRow(name: "Primary Dark", color: designKit.primaryDark)
                    colorRow(name: "Accent", color: designKit.accent)
                }

                // Semantic Actions
                sectionView(title: "Semantic Actions") {
                    colorRow(name: "Success", color: designKit.success)
                    colorRow(name: "Warning", color: designKit.warning)
                    colorRow(name: "Danger", color: designKit.danger)
                }

                // Alarm States
                sectionView(title: "Alarm States") {
                    colorRow(name: "Scheduled", color: designKit.scheduled)
                    colorRow(name: "Running", color: designKit.running)
                    colorRow(name: "Paused", color: designKit.paused)
                    colorRow(name: "Alerting", color: designKit.alerting)
                    colorRow(name: "Disabled", color: designKit.disabled)
                }

                // Text Hierarchy
                sectionView(title: "Text Hierarchy") {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text("Primary Text")
                            .foregroundColor(designKit.textPrimary(for: colorScheme))
                        Text("Secondary Text (70% opacity)")
                            .foregroundColor(designKit.textSecondary(for: colorScheme))
                        Text("Tertiary Text (50% opacity)")
                            .foregroundColor(designKit.textTertiary(for: colorScheme))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(Spacing.lg)
                }

                // Backgrounds
                sectionView(title: "Backgrounds") {
                    VStack(spacing: Spacing.md) {
                        backgroundSample(name: "Background", color: designKit.background(for: colorScheme))
                        backgroundSample(name: "Surface", color: designKit.surface(for: colorScheme))
                    }
                }
            }
            .padding(Spacing.lg)
        }
        .background(designKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Colors")
        .navigationBarTitleDisplayMode(.large)
    }

    private func sectionView<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(title)
                .headline(designKit)
                .foregroundColor(designKit.textPrimary(for: colorScheme))

            VStack(spacing: Spacing.sm) {
                content()
            }
        }
        .padding(Spacing.lg)
        .card(designKit: designKit)
    }

    private func colorRow(name: String, color: Color) -> some View {
        HStack(spacing: Spacing.md) {
            RoundedRectangle(cornerRadius: Radius.small)
                .fill(color)
                .frame(width: 60, height: 40)

            Text(name)
                .body(designKit)
                .foregroundColor(designKit.textPrimary(for: colorScheme))

            Spacer()
        }
    }

    private func backgroundSample(name: String, color: Color) -> some View {
        VStack {
            Text(name)
                .caption(designKit)
                .foregroundColor(designKit.textSecondary(for: colorScheme))

            RoundedRectangle(cornerRadius: Radius.medium)
                .fill(color)
                .frame(height: 60)
        }
    }
}

#Preview {
    NavigationStack {
        ColorsExampleView(designKit: DesignKit(DesignKitConfiguration.default))
    }
}
