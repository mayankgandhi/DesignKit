import SwiftUI
import DesignKit

struct ColorsExampleView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: DesignKit.xl) {
                // Brand Colors
                sectionView(title: "Brand Colors") {
                    colorRow(name: "Primary", color: DesignKit.primary)
                    colorRow(name: "Primary Dark", color: DesignKit.primaryDark)
                    colorRow(name: "Accent", color: DesignKit.accent)
                }

                // Semantic Actions
                sectionView(title: "Semantic Actions") {
                    colorRow(name: "Success", color: DesignKit.success)
                    colorRow(name: "Warning", color: DesignKit.warning)
                    colorRow(name: "Danger", color: DesignKit.danger)
                }

                // Alarm States
                sectionView(title: "Alarm States") {
                    colorRow(name: "Scheduled", color: DesignKit.scheduled)
                    colorRow(name: "Running", color: DesignKit.running)
                    colorRow(name: "Paused", color: DesignKit.paused)
                    colorRow(name: "Alerting", color: DesignKit.alerting)
                    colorRow(name: "Disabled", color: DesignKit.disabled)
                }

                // Text Hierarchy
                sectionView(title: "Text Hierarchy") {
                    VStack(alignment: .leading, spacing: DesignKit.md) {
                        Text("Primary Text")
                            .foregroundColor(DesignKit.textPrimary(for: colorScheme))
                        Text("Secondary Text (70% opacity)")
                            .foregroundColor(DesignKit.textSecondary(for: colorScheme))
                        Text("Tertiary Text (50% opacity)")
                            .foregroundColor(DesignKit.textTertiary(for: colorScheme))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(DesignKit.lg)
                }

                // Backgrounds
                sectionView(title: "Backgrounds") {
                    VStack(spacing: DesignKit.md) {
                        backgroundSample(name: "Background", color: DesignKit.background(for: colorScheme))
                        backgroundSample(name: "Surface", color: DesignKit.surface(for: colorScheme))
                    }
                }
            }
            .padding(DesignKit.lg)
        }
        .background(DesignKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Colors")
        .navigationBarTitleDisplayMode(.large)
    }

    private func sectionView<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: DesignKit.md) {
            Text(title)
                .headline()
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            VStack(spacing: DesignKit.sm) {
                content()
            }
        }
        .padding(DesignKit.lg)
        .card()
    }

    private func colorRow(name: String, color: Color) -> some View {
        HStack(spacing: DesignKit.md) {
            RoundedRectangle(cornerRadius: DesignKit.radiusSmall)
                .fill(color)
                .frame(width: 60, height: 40)

            Text(name)
                .body()
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            Spacer()
        }
    }

    private func backgroundSample(name: String, color: Color) -> some View {
        VStack {
            Text(name)
                .caption()
                .foregroundColor(DesignKit.textSecondary(for: colorScheme))

            RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
                .fill(color)
                .frame(height: 60)
        }
    }
}

#Preview {
    NavigationStack {
        ColorsExampleView()
    }
}
