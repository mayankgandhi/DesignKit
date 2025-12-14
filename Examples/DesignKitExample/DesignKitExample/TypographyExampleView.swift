import SwiftUI
import DesignKit

struct TypographyExampleView: View {
    let designKit: DesignKit
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // Standard Styles
                sectionView(title: "Standard Styles") {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        textSample(text: "Large Title", style: .largeTitle)
                        textSample(text: "Title", style: .title)
                        textSample(text: "Title 2", style: .title2)
                        textSample(text: "Title 3", style: .title3)
                        textSample(text: "Headline", style: .headline)
                        textSample(text: "Body", style: .body)
                        textSample(text: "Callout", style: .callout)
                        textSample(text: "Subheadline", style: .subheadline)
                        textSample(text: "Footnote", style: .footnote)
                        textSample(text: "Caption", style: .caption)
                        textSample(text: "Caption 2", style: .caption2)
                    }
                }

                // Custom App Styles
                sectionView(title: "Custom App Styles") {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        textSample(text: "12:30 PM", style: .timeDisplay)
                        textSample(text: "Ticker Title", style: .tickerTitle)
                        textSample(text: "Detail Text", style: .detailText)
                        textSample(text: "Button Text", style: .buttonText)
                        textSample(text: "Small Text", style: .smallText)
                    }
                }

                // Typography in Context
                sectionView(title: "Typography in Context") {
                    exampleCard
                }
            }
            .padding(Spacing.lg)
        }
        .background(designKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Typography")
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

    private func textSample(text: String, style: TextStyle) -> some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            Text(text)
                .applyStyle(style, using: designKit)
                .foregroundColor(designKit.textPrimary(for: colorScheme))

            Spacer()

            Text(style.rawValue)
                .caption(designKit)
                .foregroundColor(designKit.textTertiary(for: colorScheme))
        }
    }

    private var exampleCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: DesignKitIcons.alarmRunning)
                    .foregroundColor(designKit.running)

                Spacer()

                Text("Active")
                    .statusBadge(color: designKit.running, designKit: designKit)
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
        }
        .padding(Spacing.lg)
    }
}

enum TextStyle: String {
    case largeTitle = "Large Title"
    case title = "Title"
    case title2 = "Title 2"
    case title3 = "Title 3"
    case headline = "Headline"
    case body = "Body"
    case callout = "Callout"
    case subheadline = "Subheadline"
    case footnote = "Footnote"
    case caption = "Caption"
    case caption2 = "Caption 2"
    case timeDisplay = "Time Display"
    case tickerTitle = "Ticker Title"
    case detailText = "Detail Text"
    case buttonText = "Button Text"
    case smallText = "Small Text"
}

extension Text {
    func applyStyle(_ style: TextStyle, using designKit: DesignKit) -> some View {
        switch style {
        case .largeTitle: return AnyView(self.largeTitle(designKit))
        case .title: return AnyView(self.title(designKit))
        case .title2: return AnyView(self.title2(designKit))
        case .title3: return AnyView(self.title3(designKit))
        case .headline: return AnyView(self.headline(designKit))
        case .body: return AnyView(self.body(designKit))
        case .callout: return AnyView(self.callout(designKit))
        case .subheadline: return AnyView(self.subheadline(designKit))
        case .footnote: return AnyView(self.footnote(designKit))
        case .caption: return AnyView(self.caption(designKit))
        case .caption2: return AnyView(self.caption2(designKit))
        case .timeDisplay: return AnyView(self.timeDisplay(designKit))
        case .tickerTitle: return AnyView(self.tickerTitle(designKit))
        case .detailText: return AnyView(self.detailText(designKit))
        case .buttonText: return AnyView(self.buttonText(designKit))
        case .smallText: return AnyView(self.smallText(designKit))
        }
    }
}

#Preview {
    NavigationStack {
        TypographyExampleView(designKit: DesignKit(DesignKitConfiguration.default))
    }
}
