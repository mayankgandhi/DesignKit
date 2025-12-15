import SwiftUI
import DesignKit

@main
struct DesignKitExampleApp: App {
    // Create a DesignKit instance with custom design tokens
    let designKit = DesignKit(
        DesignKitConfiguration(
            colors: ColorConfiguration(
                primary: Color(red: 0.0, green: 0.48, blue: 1.0),
                primaryDark: Color(red: 0.0, green: 0.38, blue: 0.8),
                accent: Color(red: 1.0, green: 0.58, blue: 0.0),
                success: Color(red: 0.2, green: 0.78, blue: 0.35),
                warning: Color(red: 1.0, green: 0.8, blue: 0.0),
                danger: Color(red: 1.0, green: 0.23, blue: 0.19),
                scheduled: Color(red: 0.0, green: 0.48, blue: 1.0),
                running: Color(red: 0.2, green: 0.78, blue: 0.35),
                paused: Color(red: 1.0, green: 0.8, blue: 0.0),
                alerting: Color(red: 1.0, green: 0.23, blue: 0.19)
            ),
            typography: TypographyConfiguration(
                fontDesign: .serif
            )
        )
    )

    var body: some Scene {
        WindowGroup {
            ContentView(designKit: designKit)
        }
    }
}
