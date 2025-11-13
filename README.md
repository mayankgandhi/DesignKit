# DesignKit

A shared design system framework for SwiftUI applications, providing consistent colors, typography, spacing, animations, and UI components across multiple apps.

## Features

- **Color System**: Comprehensive color palette with semantic colors, alarm states, and automatic dark mode support
- **Typography**: Flexible typography system with configurable font families and styles
- **Spacing & Layout**: Consistent spacing tokens for unified layouts
- **Animations**: Pre-configured animation curves and durations
- **Shadows & Radius**: Standardized shadow depths and corner radius values
- **Components**: Reusable SwiftUI components including button styles, view modifiers, haptics, and icons
- **Liquid Glass Backgrounds**: Beautiful gradient backgrounds that adapt to light and dark modes
- **Zero Dependencies**: Pure SwiftUI with no external dependencies

## Installation

### Swift Package Manager

Add DesignKit to your project using Swift Package Manager:

1. In Xcode, select **File** → **Add Package Dependencies...**
2. Enter the repository URL:
   ```
   https://github.com/mayankgandhi/DesignKit.git
   ```
3. Select the version or branch you want to use
4. Click **Add Package**

Alternatively, add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/mayankgandhi/DesignKit.git", from: "1.0.0")
]
```

Then add DesignKit as a dependency to your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["DesignKit"]
)
```

## Usage

### 1. Configure DesignKit

Configure DesignKit at app launch (typically in your `App` struct):

```swift
import SwiftUI
import DesignKit

@main
struct YourApp: App {
    init() {
        // Configure DesignKit with your design tokens
        DesignKit.configure(
            DesignKitConfiguration(
                colors: ColorConfiguration(
                    absoluteBlack: Color(red: 0.0, green: 0.0, blue: 0.0),
                    absoluteWhite: Color(red: 1.0, green: 1.0, blue: 1.0),
                    surfaceDark: Color(red: 0.1, green: 0.1, blue: 0.1),
                    surfaceLight: Color(red: 0.95, green: 0.95, blue: 0.97),
                    primary: Color(red: 0.0, green: 0.48, blue: 1.0),
                    primaryDark: Color(red: 0.0, green: 0.38, blue: 0.8),
                    accent: Color(red: 1.0, green: 0.58, blue: 0.0),
                    success: Color(red: 0.2, green: 0.78, blue: 0.35),
                    warning: Color(red: 1.0, green: 0.8, blue: 0.0),
                    danger: Color(red: 1.0, green: 0.23, blue: 0.19),
                    scheduled: Color(red: 0.0, green: 0.48, blue: 1.0),
                    running: Color(red: 0.2, green: 0.78, blue: 0.35),
                    paused: Color(red: 1.0, green: 0.8, blue: 0.0),
                    alerting: Color(red: 1.0, green: 0.23, blue: 0.19),
                    disabled: Color.gray.opacity(0.5)
                ),
                typography: TypographyConfiguration(
                    fontFamily: "SF Pro",
                    displayFont: "SF Pro Display",
                    monoFont: "SF Mono"
                )
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### 2. Use DesignKit Components

#### Colors

```swift
import SwiftUI
import DesignKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: DesignKit.spacing.medium) {
            Text("Hello, World!")
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            Button("Primary Action") {
                // Action
            }
            .foregroundColor(DesignKit.primary)
        }
        .padding(DesignKit.spacing.large)
        .background(DesignKit.background(for: colorScheme))
    }
}
```

#### Typography

```swift
Text("Large Title")
    .font(DesignKit.typography.largeTitle)

Text("Body Text")
    .font(DesignKit.typography.body)
```

#### Spacing

```swift
VStack(spacing: DesignKit.spacing.medium) {
    // Content
}
.padding(DesignKit.spacing.large)
```

#### Animations

```swift
Text("Animated")
    .animation(DesignKit.animation.spring, value: someValue)
```

#### Liquid Glass Background

```swift
ZStack {
    DesignKit.liquidGlassGradient(for: colorScheme)
        .ignoresSafeArea()

    // Your content here
}
```

## Platform Support

- iOS 15.0+
- macOS 12.0+
- Mac Catalyst 15.0+

## Requirements

- Swift 5.9+
- Xcode 15.0+

## License

MIT License - See LICENSE file for details

## Version

Current version: 1.0.0
