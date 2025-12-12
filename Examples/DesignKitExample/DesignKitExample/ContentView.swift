import SwiftUI
import DesignKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: DesignKit.xl) {
                    // Header Section
                    headerSection

                    // Colors Section
                    NavigationLink(destination: ColorsExampleView()) {
                        exampleCard(
                            title: "Colors",
                            description: "Brand colors, semantic actions, and text hierarchy",
                            icon: DesignKitIcons.settings
                        )
                    }

                    // Typography Section
                    NavigationLink(destination: TypographyExampleView()) {
                        exampleCard(
                            title: "Typography",
                            description: "Text styles and font configurations",
                            icon: DesignKitIcons.edit
                        )
                    }

                    // Components Section
                    NavigationLink(destination: ComponentsExampleView()) {
                        exampleCard(
                            title: "Components",
                            description: "Buttons, cards, badges, and more",
                            icon: DesignKitIcons.settings
                        )
                    }

                    // Spacing Section
                    NavigationLink(destination: SpacingExampleView()) {
                        exampleCard(
                            title: "Spacing",
                            description: "8-point spacing system",
                            icon: DesignKitIcons.settings
                        )
                    }

                    // Molecules Section
                    NavigationLink(destination: MoleculesExampleView()) {
                        exampleCard(
                            title: "Molecules",
                            description: "Complex UI components like buttons, cards, and forms",
                            icon: "square.grid.2x2"
                        )
                    }
                }
                .padding(DesignKit.lg)
            }
            .background(DesignKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
            .navigationTitle("DesignKit")
        }
    }

    private var headerSection: some View {
        VStack(spacing: DesignKit.md) {
            Text("DesignKit")
                .largeTitle()
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            Text("A comprehensive SwiftUI design system")
                .body()
                .foregroundColor(DesignKit.textSecondary(for: colorScheme))
                .multilineTextAlignment(.center)
        }
        .padding(DesignKit.xl)
    }

    private func exampleCard(title: String, description: String, icon: String) -> some View {
        HStack(spacing: DesignKit.md) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(DesignKit.primary)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: DesignKit.xxs) {
                Text(title)
                    .headline()
                    .foregroundColor(DesignKit.textPrimary(for: colorScheme))

                Text(description)
                    .footnote()
                    .foregroundColor(DesignKit.textSecondary(for: colorScheme))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(DesignKit.textTertiary(for: colorScheme))
        }
        .padding(DesignKit.lg)
        .card()
    }
}

#Preview {
    ContentView()
}
