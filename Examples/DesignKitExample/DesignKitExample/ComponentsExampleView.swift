import SwiftUI
import DesignKit

struct ComponentsExampleView: View {
    let designKit: DesignKit
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // Button Styles
                sectionView(title: "Button Styles") {
                    VStack(spacing: Spacing.md) {
                        Button("Primary Button") {
                            DesignKitHaptics.standardAction()
                        }
                        .primaryButton(designKit: designKit)

                        Button("Destructive Button") {
                            DesignKitHaptics.criticalAction()
                        }
                        .primaryButton(isDestructive: true, designKit: designKit)

                        Button("Secondary Button") {
                            DesignKitHaptics.selection()
                        }
                        .secondaryButton(designKit: designKit)

                        Button("Tertiary Button") {
                            DesignKitHaptics.selection()
                        }
                        .tertiaryButton(designKit: designKit)

                        Button("Disabled Button") {
                            // No action
                        }
                        .primaryButton(designKit: designKit)
                        .disabled(true)
                    }
                }

                // Card Modifier
                sectionView(title: "Card Modifier") {
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text("Card Example")
                            .headline(designKit)
                            .foregroundColor(designKit.textPrimary(for: colorScheme))

                        Text("This is a card with surface background, corner radius, and subtle shadow.")
                            .body(designKit)
                            .foregroundColor(designKit.textSecondary(for: colorScheme))
                    }
                    .padding(Spacing.lg)
                    .card(designKit: designKit)
                }

                // Status Badges
                sectionView(title: "Status Badges") {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        HStack(spacing: Spacing.sm) {
                            Text("Success")
                                .statusBadge(color: designKit.success, designKit: designKit)
                            Text("Warning")
                                .statusBadge(color: designKit.warning, designKit: designKit)
                            Text("Danger")
                                .statusBadge(color: designKit.danger, designKit: designKit)
                        }

                        HStack(spacing: Spacing.sm) {
                            Text("Scheduled")
                                .statusBadge(color: designKit.scheduled, designKit: designKit)
                            Text("Running")
                                .statusBadge(color: designKit.running, designKit: designKit)
                            Text("Paused")
                                .statusBadge(color: designKit.paused, designKit: designKit)
                        }

                        HStack(spacing: Spacing.sm) {
                            Text("Alerting")
                                .statusBadge(color: designKit.alerting, designKit: designKit)
                            Text("Disabled")
                                .statusBadge(color: designKit.disabled, designKit: designKit)
                        }
                    }
                }

                // Icons
                sectionView(title: "Icon System") {
                    VStack(spacing: Spacing.md) {
                        iconRow(title: "Alarm States", icons: [
                            (DesignKitIcons.alarmScheduled, "Scheduled"),
                            (DesignKitIcons.alarmRunning, "Running"),
                            (DesignKitIcons.alarmPaused, "Paused"),
                            (DesignKitIcons.alarmAlerting, "Alerting")
                        ])

                        iconRow(title: "Actions", icons: [
                            (DesignKitIcons.add, "Add"),
                            (DesignKitIcons.delete, "Delete"),
                            (DesignKitIcons.edit, "Edit"),
                            (DesignKitIcons.settings, "Settings")
                        ])

                        iconRow(title: "Status", icons: [
                            (DesignKitIcons.success, "Success"),
                            (DesignKitIcons.warning, "Warning"),
                            (DesignKitIcons.error, "Error"),
                            (DesignKitIcons.info, "Info")
                        ])
                    }
                }

                // Complete Card Example
                sectionView(title: "Complete Example") {
                    completeCardExample
                }

                // Haptic Feedback Demo
                sectionView(title: "Haptic Feedback") {
                    VStack(spacing: Spacing.sm) {
                        hapticsButton(title: "Light Impact", haptic: .light)
                        hapticsButton(title: "Medium Impact", haptic: .medium)
                        hapticsButton(title: "Heavy Impact", haptic: .heavy)
                        hapticsButton(title: "Success", haptic: .success)
                        hapticsButton(title: "Warning", haptic: .warning)
                        hapticsButton(title: "Error", haptic: .error)
                    }
                }
            }
            .padding(Spacing.lg)
        }
        .background(designKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Components")
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

    private func iconRow(title: String, icons: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(title)
                .caption(designKit)
                .foregroundColor(designKit.textSecondary(for: colorScheme))

            HStack(spacing: Spacing.md) {
                ForEach(icons, id: \.0) { icon in
                    VStack(spacing: Spacing.xxs) {
                        Image(systemName: icon.0)
                            .font(.system(size: 24))
                            .foregroundColor(designKit.primary)

                        Text(icon.1)
                            .caption2(designKit)
                            .foregroundColor(designKit.textTertiary(for: colorScheme))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private var completeCardExample: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: DesignKitIcons.alarmRunning)
                    .foregroundColor(isActive ? designKit.running : designKit.disabled)

                Spacer()

                Text(isActive ? "Active" : "Inactive")
                    .statusBadge(
                        color: isActive ? designKit.running : designKit.disabled,
                        designKit: designKit
                    )
            }

            Text("07:00 AM")
                .timeDisplay(designKit)
                .foregroundColor(designKit.textPrimary(for: colorScheme))

            Text("Wake up alarm")
                .tickerTitle(designKit)
                .foregroundColor(designKit.textSecondary(for: colorScheme))

            Text("Repeats: Mon-Fri")
                .detailText(designKit)
                .foregroundColor(designKit.textTertiary(for: colorScheme))

            HStack(spacing: Spacing.sm) {
                Button("Edit") {
                    DesignKitHaptics.selection()
                }
                .secondaryButton(designKit: designKit)

                Button(isActive ? "Disable" : "Enable") {
                    DesignKitHaptics.standardAction()
                    withAnimation(SwiftUI.Animation.spring) {
                        isActive.toggle()
                    }
                }
                .primaryButton(designKit: designKit)
            }
        }
        .padding(Spacing.lg)
    }

    private func hapticsButton(title: String, haptic: HapticType) -> some View {
        Button(title) {
            switch haptic {
            case .light: DesignKitHaptics.impact(.light)
            case .medium: DesignKitHaptics.impact(.medium)
            case .heavy: DesignKitHaptics.impact(.heavy)
            case .success: DesignKitHaptics.success()
            case .warning: DesignKitHaptics.warning()
            case .error: DesignKitHaptics.error()
            }
        }
        .secondaryButton(designKit: designKit)
    }
}

enum HapticType {
    case light, medium, heavy, success, warning, error
}

#Preview {
    NavigationStack {
        ComponentsExampleView(designKit: DesignKit(DesignKitConfiguration.default))
    }
}
