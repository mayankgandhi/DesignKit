import SwiftUI
import DesignKit

struct TypographyExampleView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: DesignKit.xl) {
                // Standard Styles
                sectionView(title: "Standard Styles") {
                    VStack(alignment: .leading, spacing: DesignKit.md) {
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
                    VStack(alignment: .leading, spacing: DesignKit.md) {
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
            .padding(DesignKit.lg)
        }
        .background(DesignKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Typography")
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

    private func textSample(text: String, style: TextStyle) -> some View {
        HStack(alignment: .top, spacing: DesignKit.md) {
            Text(text)
                .applyStyle(style)
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            Spacer()

            Text(style.rawValue)
                .caption()
                .foregroundColor(DesignKit.textTertiary(for: colorScheme))
        }
    }

    private var exampleCard: some View {
        VStack(alignment: .leading, spacing: DesignKit.md) {
            HStack {
                Image(systemName: DesignKitIcons.alarmRunning)
                    .foregroundColor(DesignKit.running)

                Spacer()

                Text("Active")
                    .statusBadge(color: DesignKit.running)
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
        }
        .padding(DesignKit.lg)
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
    func applyStyle(_ style: TextStyle) -> some View {
        switch style {
        case .largeTitle: return AnyView(self.largeTitle())
        case .title: return AnyView(self.title())
        case .title2: return AnyView(self.title2())
        case .title3: return AnyView(self.title3())
        case .headline: return AnyView(self.headline())
        case .body: return AnyView(self.body())
        case .callout: return AnyView(self.callout())
        case .subheadline: return AnyView(self.subheadline())
        case .footnote: return AnyView(self.footnote())
        case .caption: return AnyView(self.caption())
        case .caption2: return AnyView(self.caption2())
        case .timeDisplay: return AnyView(self.timeDisplay())
        case .tickerTitle: return AnyView(self.tickerTitle())
        case .detailText: return AnyView(self.detailText())
        case .buttonText: return AnyView(self.buttonText())
        case .smallText: return AnyView(self.smallText())
        }
    }
}

#Preview {
    NavigationStack {
        TypographyExampleView()
    }
}
