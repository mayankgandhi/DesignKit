import SwiftUI
import DesignKit

struct ContentView: View {
    let designKit: DesignKit
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Header Section
                    headerSection

                    // Colors Section
                    NavigationLink(destination: ColorsExampleView(designKit: designKit)) {
                        exampleCard(
                            title: "Colors",
                            description: "Brand colors, semantic actions, and text hierarchy",
                            icon: DesignKitIcons.settings
                        )
                    }

                    // Typography Section
                    NavigationLink(destination: TypographyExampleView(designKit: designKit)) {
                        exampleCard(
                            title: "Typography",
                            description: "Text styles and font configurations",
                            icon: DesignKitIcons.edit
                        )
                    }

                    // Components Section
                    NavigationLink(destination: ComponentsExampleView(designKit: designKit)) {
                        exampleCard(
                            title: "Components",
                            description: "Buttons, cards, badges, and more",
                            icon: DesignKitIcons.settings
                        )
                    }

                    // Spacing Section
                    NavigationLink(
                        destination: SpacingExampleView(designKit: designKit)
                    ) {
                        exampleCard(
                            title: "Spacing",
                            description: "8-point spacing system",
                            icon: DesignKitIcons.settings
                        )
                    }

                    // Molecules Section
                    NavigationLink(destination: MoleculesExampleView(designKit: designKit)) {
                        exampleCard(
                            title: "Molecules",
                            description: "Complex UI components like buttons, cards, and forms",
                            icon: "square.grid.2x2"
                        )
                    }

                    // AI Components Section
                    NavigationLink(destination: AddProductView(designKit: designKit)) {
                        exampleCard(
                            title: "AI Components",
                            description: "AI-assisted text fields and smart input",
                            icon: "sparkles"
                        )
                    }
                }
                .padding(Spacing.lg)
            }
            .background(designKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
            .navigationTitle("DesignKit")
        }
    }

    private var headerSection: some View {
        VStack(spacing: Spacing.md) {
            Text("DesignKit")
                .largeTitle(designKit)
                .foregroundColor(designKit.textPrimary(for: colorScheme))

            Text("A comprehensive SwiftUI design system")
                .body(designKit)
                .foregroundColor(designKit.textSecondary(for: colorScheme))
                .multilineTextAlignment(.center)
        }
        .padding(Spacing.xl)
    }

    private func exampleCard(title: String, description: String, icon: String) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(designKit.primary)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(title)
                    .headline(designKit)
                    .foregroundColor(designKit.textPrimary(for: colorScheme))

                Text(description)
                    .footnote(designKit)
                    .foregroundColor(designKit.textSecondary(for: colorScheme))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(designKit.textTertiary(for: colorScheme))
        }
        .padding(Spacing.lg)
        .card(designKit: designKit)
    }
}

#Preview {
    ContentView(designKit: DesignKit(DesignKitConfiguration.default))
}
