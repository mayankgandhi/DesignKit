import SwiftUI
import DesignKit

struct ComponentsExampleView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false

    var body: some View {
        ScrollView {
            VStack(spacing: DesignKit.xl) {
                // Button Styles
                sectionView(title: "Button Styles") {
                    VStack(spacing: DesignKit.md) {
                        Button("Primary Button") {
                            DesignKitHaptics.standardAction()
                        }
                        .primaryButton()

                        Button("Destructive Button") {
                            DesignKitHaptics.criticalAction()
                        }
                        .primaryButton(isDestructive: true)

                        Button("Secondary Button") {
                            DesignKitHaptics.selection()
                        }
                        .secondaryButton()

                        Button("Tertiary Button") {
                            DesignKitHaptics.selection()
                        }
                        .tertiaryButton()

                        Button("Disabled Button") {
                            // No action
                        }
                        .primaryButton()
                        .disabled(true)
                    }
                }

                // Card Modifier
                sectionView(title: "Card Modifier") {
                    VStack(alignment: .leading, spacing: DesignKit.sm) {
                        Text("Card Example")
                            .headline()
                            .foregroundColor(DesignKit.textPrimary(for: colorScheme))

                        Text("This is a card with surface background, corner radius, and subtle shadow.")
                            .body()
                            .foregroundColor(DesignKit.textSecondary(for: colorScheme))
                    }
                    .padding(DesignKit.lg)
                    .card()
                }

                // Status Badges
                sectionView(title: "Status Badges") {
                    VStack(alignment: .leading, spacing: DesignKit.md) {
                        HStack(spacing: DesignKit.sm) {
                            Text("Success")
                                .statusBadge(color: DesignKit.success)
                            Text("Warning")
                                .statusBadge(color: DesignKit.warning)
                            Text("Danger")
                                .statusBadge(color: DesignKit.danger)
                        }

                        HStack(spacing: DesignKit.sm) {
                            Text("Scheduled")
                                .statusBadge(color: DesignKit.scheduled)
                            Text("Running")
                                .statusBadge(color: DesignKit.running)
                            Text("Paused")
                                .statusBadge(color: DesignKit.paused)
                        }

                        HStack(spacing: DesignKit.sm) {
                            Text("Alerting")
                                .statusBadge(color: DesignKit.alerting)
                            Text("Disabled")
                                .statusBadge(color: DesignKit.disabled)
                        }
                    }
                }

                // Icons
                sectionView(title: "Icon System") {
                    VStack(spacing: DesignKit.md) {
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
                    VStack(spacing: DesignKit.sm) {
                        hapticsButton(title: "Light Impact", haptic: .light)
                        hapticsButton(title: "Medium Impact", haptic: .medium)
                        hapticsButton(title: "Heavy Impact", haptic: .heavy)
                        hapticsButton(title: "Success", haptic: .success)
                        hapticsButton(title: "Warning", haptic: .warning)
                        hapticsButton(title: "Error", haptic: .error)
                    }
                }
            }
            .padding(DesignKit.lg)
        }
        .background(DesignKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Components")
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

    private func iconRow(title: String, icons: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: DesignKit.sm) {
            Text(title)
                .caption()
                .foregroundColor(DesignKit.textSecondary(for: colorScheme))

            HStack(spacing: DesignKit.md) {
                ForEach(icons, id: \.0) { icon in
                    VStack(spacing: DesignKit.xxs) {
                        Image(systemName: icon.0)
                            .font(.system(size: 24))
                            .foregroundColor(DesignKit.primary)

                        Text(icon.1)
                            .caption2()
                            .foregroundColor(DesignKit.textTertiary(for: colorScheme))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private var completeCardExample: some View {
        VStack(alignment: .leading, spacing: DesignKit.md) {
            HStack {
                Image(systemName: DesignKitIcons.alarmRunning)
                    .foregroundColor(isActive ? DesignKit.running : DesignKit.disabled)

                Spacer()

                Text(isActive ? "Active" : "Inactive")
                    .statusBadge(color: isActive ? DesignKit.running : DesignKit.disabled)
            }

            Text("07:00 AM")
                .timeDisplay()
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            Text("Wake up alarm")
                .tickerTitle()
                .foregroundColor(DesignKit.textSecondary(for: colorScheme))

            Text("Repeats: Mon-Fri")
                .detailText()
                .foregroundColor(DesignKit.textTertiary(for: colorScheme))

            HStack(spacing: DesignKit.sm) {
                Button("Edit") {
                    DesignKitHaptics.selection()
                }
                .secondaryButton()

                Button(isActive ? "Disable" : "Enable") {
                    DesignKitHaptics.standardAction()
                    withAnimation(DesignKit.animationSpring) {
                        isActive.toggle()
                    }
                }
                .primaryButton()
            }
        }
        .padding(DesignKit.lg)
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
        .secondaryButton()
    }
}

enum HapticType {
    case light, medium, heavy, success, warning, error
}

#Preview {
    NavigationStack {
        ComponentsExampleView()
    }
}
