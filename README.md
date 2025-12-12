# DesignKit

A comprehensive SwiftUI design system framework providing consistent colors, typography, spacing, animations, shadows, and reusable components for building beautiful iOS applications.

> **Platform Requirements:** DesignKit targets iOS 17.0+, macOS 13.0+, and Mac Catalyst 15.0+. Ensure your deployment target matches before integration.

## Features

- **Color System**: Comprehensive color palette with base colors, brand colors, semantic actions, alarm states, and automatic dark mode support
- **Typography System**: Flexible typography with configurable font designs and 16 pre-defined text styles
- **Spacing Tokens**: Consistent 8-point spacing system from 4pt to 64pt, plus component-specific spacing
- **Animation Presets**: Pre-configured animation curves for instant, quick, standard, pulse, and spring animations
- **Shadow Depths**: Three elevation levels (subtle, elevated, critical) for visual hierarchy
- **Corner Radius**: Seven radius options from sharp to full circle for consistent component styling
- **Button Styles**: Primary, secondary, and tertiary button styles with automatic state management
- **Haptic Feedback**: Contextual haptic patterns for user interactions
- **Icon System**: Curated SF Symbols collection for common UI patterns
- **View Modifiers**: Reusable modifiers for cards and status badges
- **Liquid Glass Backgrounds**: Beautiful multi-layered gradient backgrounds that adapt to light/dark modes
- **Molecule Components**: Production-ready UI components including buttons, cards, form inputs, navigation headers, and notifications
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

## Quick Start

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
                    fontDesign: .rounded  // Options: .rounded, .serif, .monospaced, .default
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

### 2. Use DesignKit in Your Views

```swift
import SwiftUI
import DesignKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: DesignKit.lg) {
            Text("Welcome to DesignKit")
                .largeTitle()
                .foregroundColor(DesignKit.textPrimary(for: colorScheme))

            Button("Get Started") {
                DesignKitHaptics.success()
            }
            .primaryButton()
        }
        .padding(DesignKit.xl)
        .background(DesignKit.liquidGlassGradient(for: colorScheme))
    }
}
```

## API Reference

### Configuration

#### DesignKitConfiguration

Complete design system configuration combining colors and typography.

```swift
DesignKitConfiguration(
    colors: ColorConfiguration,
    typography: TypographyConfiguration
)
```

#### ColorConfiguration

Configure your brand colors, semantic actions, and alarm states.

**Base Colors:**
- `absoluteBlack` - Pure black (default: `#000000`)
- `absoluteWhite` - Pure white (default: `#FFFFFF`)
- `surfaceDark` - Dark mode surface (default: `#1C1C1E`)
- `surfaceLight` - Light mode surface (default: `#F5F5F7`)

**Brand Colors:**
- `primary` - Primary brand color (required)
- `primaryDark` - Darker primary variant (required)
- `accent` - Accent/secondary brand color (required)

**Semantic Actions:**
- `success` - Success state color (required)
- `warning` - Warning state color (required)
- `danger` - Danger/destructive action color (required)

**Alarm States:**
- `scheduled` - Scheduled alarm state (required)
- `running` - Active/running state (required)
- `paused` - Paused state (required)
- `alerting` - Alerting/urgent state (required)
- `disabled` - Disabled state (default: `#959598`)

#### TypographyConfiguration

Configure font design and optional custom font family.

```swift
TypographyConfiguration(
    fontDesign: Font.Design = .rounded,  // .default, .rounded, .serif, .monospaced
    fontFamily: String? = nil            // Optional custom font name
)
```

### Colors API

Access configured colors through the `DesignKit` namespace:

**Base Colors:**
```swift
DesignKit.absoluteBlack
DesignKit.absoluteWhite
DesignKit.surfaceDark
DesignKit.surfaceLight
```

**Brand Colors:**
```swift
DesignKit.primary
DesignKit.primaryDark
DesignKit.accent
```

**Semantic Actions:**
```swift
DesignKit.success
DesignKit.warning
DesignKit.danger
```

**Alarm States:**
```swift
DesignKit.scheduled
DesignKit.running
DesignKit.paused
DesignKit.alerting
DesignKit.disabled
```

**Text Hierarchy:**
```swift
DesignKit.textPrimary(for: colorScheme)    // Maximum contrast
DesignKit.textSecondary(for: colorScheme)  // 70% opacity
DesignKit.textTertiary(for: colorScheme)   // 50% opacity
```

**Backgrounds:**
```swift
DesignKit.background(for: colorScheme)  // Pure black/white
DesignKit.surface(for: colorScheme)     // Elevated surface
```

**Liquid Glass Gradient:**
```swift
DesignKit.liquidGlassGradient(for: colorScheme)
```

Example:
```swift
ZStack {
    DesignKit.liquidGlassGradient(for: colorScheme)
        .ignoresSafeArea()

    // Your content here
}
```

### Typography API

DesignKit provides 16 text styles accessible through static functions or View extensions:

**Standard Styles:**
```swift
// Static function usage
Text("Title").font(DesignKit.largeTitle())
Text("Body").font(DesignKit.body())

// View extension usage
Text("Title").largeTitle()
Text("Body").body()
```

**Available Styles:**
- `largeTitle()` - Large title (bold)
- `title()` - Title 1 (bold)
- `title2()` - Title 2 (bold)
- `title3()` - Title 3 (semibold)
- `headline()` - Headline (semibold)
- `body()` - Body text (regular)
- `callout()` - Callout (regular)
- `subheadline()` - Subheadline (semibold)
- `footnote()` - Footnote (medium)
- `caption()` - Caption 1 (medium)
- `caption2()` - Caption 2 (regular)

**Custom App Styles:**
- `timeDisplay()` - 28pt bold - for card time displays
- `tickerTitle()` - 18pt semibold - for ticker names
- `detailText()` - 15pt medium - for schedule details
- `buttonText()` - 14pt semibold - for buttons and labels
- `smallText()` - 12pt medium - for secondary info

Example:
```swift
VStack(alignment: .leading, spacing: DesignKit.sm) {
    Text("12:30 PM").timeDisplay()
    Text("Daily Standup").tickerTitle()
    Text("Recurring: Mon-Fri").detailText()
}
```

### Spacing API

8-point spacing system for consistent layouts:

**Core Spacing:**
```swift
DesignKit.xxs   // 4pt - Micro spacing
DesignKit.xs    // 8pt - Tiny spacing
DesignKit.sm    // 12pt - Small spacing
DesignKit.md    // 16pt - Base unit
DesignKit.lg    // 24pt - Medium-large spacing
DesignKit.xl    // 32pt - Large spacing
DesignKit.xxl   // 48pt - Extra large spacing
DesignKit.xxxl  // 64pt - Section breaks
```

**Component Spacing:**
```swift
DesignKit.tapTargetMin           // 44pt - Minimum tap target
DesignKit.tapTargetPreferred     // 56pt - Preferred tap target
DesignKit.buttonHeightLarge      // 64pt - Large button height
DesignKit.buttonHeightStandard   // 48pt - Standard button height
```

Example:
```swift
VStack(spacing: DesignKit.md) {
    Text("Title")
    Text("Body")
}
.padding(DesignKit.lg)
```

### Animation API

Pre-configured animation curves:

```swift
DesignKit.animationInstant   // 0.1s easeOut - Critical actions
DesignKit.animationQuick     // 0.2s easeInOut - UI feedback
DesignKit.animationStandard  // 0.3s easeInOut - Transitions
DesignKit.animationPulse     // 1.0s repeating - Active alarms
DesignKit.animationSpring    // Spring physics - Tactile feedback
```

Example:
```swift
Text("Animated")
    .opacity(isVisible ? 1 : 0)
    .animation(DesignKit.animationStandard, value: isVisible)
```

### Shadow API

Three elevation levels for visual hierarchy:

```swift
DesignKit.shadowCritical  // High contrast (0.3 opacity, 8pt blur, 4pt offset)
DesignKit.shadowElevated  // Medium depth (0.15 opacity, 12pt blur, 6pt offset)
DesignKit.shadowSubtle    // Gentle depth (0.08 opacity, 4pt blur, 2pt offset)
```

Example:
```swift
RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
    .fill(Color.white)
    .shadow(
        color: DesignKit.shadowElevated.color,
        radius: DesignKit.shadowElevated.radius,
        x: DesignKit.shadowElevated.x,
        y: DesignKit.shadowElevated.y
    )
```

### Corner Radius API

Consistent corner radius values:

```swift
DesignKit.radiusNone     // 0pt - Sharp corners
DesignKit.radiusTight    // 4pt - Tight radius
DesignKit.radiusSmall    // 8pt - Small radius
DesignKit.radiusMedium   // 12pt - Medium radius
DesignKit.large          // 16pt - Large radius (note: inconsistent naming)
DesignKit.radiusXLarge   // 24pt - Extra large radius
DesignKit.radiusFull     // 999pt - Full circle
```

Example:
```swift
RoundedRectangle(cornerRadius: DesignKit.radiusMedium)
```

## Components

### Button Styles

DesignKit provides three button styles with automatic state management:

**Primary Button:**
```swift
Button("Save") { }
    .primaryButton()

Button("Delete") { }
    .primaryButton(isDestructive: true)
```
- Full-width with max height of 64pt
- White text on primary (or danger if destructive) background
- Shadow and scale effects on press
- Automatic disabled state styling

**Secondary Button:**
```swift
Button("Cancel") { }
    .secondaryButton()
```
- Full-width with height of 48pt
- Outlined style with surface background
- Adapts to color scheme automatically
- Automatic disabled state styling

**Tertiary Button:**
```swift
Button("Learn More") { }
    .tertiaryButton()
```
- Text-only button with minimal padding
- Scale effect on press
- Automatic disabled state styling

### Molecules

DesignKit provides production-ready molecule components for building complete user interfaces. Molecules are pre-built, reusable UI components that combine design tokens with best practices.

#### Buttons

**DSButton**

Modern button component with three style variants:

```swift
DSButton("Save Changes", style: .primary) {
    // Handle action
}

DSButton("Cancel", style: .secondary) {
    // Handle action
}

DSButton("Delete", style: .destructive, icon: "trash") {
    // Handle action
}
```

**HealthIconButton**

Icon-only button for compact interfaces:

```swift
HStack(spacing: DesignKit.md) {
    HealthIconButton(icon: "heart.fill", style: .primary) {
        // Handle action
    }
    HealthIconButton(icon: "plus", style: .secondary) {
        // Handle action
    }
}
```

#### Cards

**DSCard**

Informational card with icon, title, and subtitle:

```swift
DSCard(
    title: "Getting Started",
    subtitle: "Learn the basics",
    imageName: "book.fill",
    backgroundColor: DesignKit.primary
)
```

#### Navigation

**NavBarHeader**

Navigation header with gradient icon and title/subtitle:

```swift
NavBarHeader(
    icon: "pills.fill",
    iconColor: DesignKit.primary,
    title: "Medications",
    subtitle: "Manage your prescriptions"
)
```

**SearchBar**

Search bar with clear button and callbacks:

```swift
@State private var searchText = ""

SearchBar(
    searchText: $searchText,
    placeholder: "Search items...",
    onTextChange: { text in
        // Handle search
    },
    onClear: {
        // Handle clear
    }
)
```

#### List Items

**MenuListItem**

Rich menu item with icon, title, subtitle, badge, and chevron:

```swift
MenuListItem(
    icon: "book.fill",
    title: "Diary",
    subtitle: "Track your daily entries",
    iconColor: DesignKit.primary,
    badge: 3
) {
    // Handle tap
}
```

#### Form Inputs

**TextFieldItem**

Text field with validation states, helper text, and error messages:

```swift
@State private var email = ""

TextFieldItem(
    icon: "envelope.fill",
    title: "Email Address",
    text: $email,
    placeholder: "Enter your email",
    helperText: "We'll never share your email",
    iconColor: .blue,
    isRequired: true,
    keyboardType: .emailAddress,
    contentType: .emailAddress
)
```

**MenuPickerItem**

Menu picker with validation states:

```swift
@State private var selectedBloodType: String? = nil

MenuPickerItem(
    icon: "drop.fill",
    title: "Blood Type",
    selectedOption: $selectedBloodType,
    options: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
    placeholder: "Select your blood type",
    helperText: "Select your blood type from the list",
    iconColor: .red,
    isRequired: true
)
```

**DatePickerItem**

Date picker with validation states:

```swift
@State private var selectedDate: Date? = nil

DatePickerItem(
    icon: "calendar",
    title: "Date of Birth",
    selectedDate: $selectedDate,
    helperText: "Used for age calculations",
    iconColor: .blue,
    isRequired: true,
    displayedComponents: [.date]
)
```

**ColorPickerItem**

Color picker with predefined palette:

```swift
@State private var selectedColor = "#FF6B6B"

ColorPickerItem(
    icon: "paintpalette.fill",
    title: "Theme Color",
    selectedColorHex: $selectedColor,
    helperText: "Choose your profile theme color"
)
```

**ToggleItem**

Toggle switch with icon, title, and subtitle:

```swift
@State private var notificationsEnabled = true

ToggleItem(
    icon: "bell.fill",
    title: "Notifications",
    subtitle: "Get notified about important updates",
    isOn: $notificationsEnabled,
    helperText: "Push notifications will be sent to your device",
    iconColor: .orange
)
```

#### Notifications

**SuccessNotification**

Success notification with animated droplet:

```swift
SuccessNotification(
    message: "Success!",
    timestamp: "Just now",
    value: "120",
    unit: "mg/dL",
    status: "Normal range"
)
```

### Haptic Feedback

Contextual haptic patterns using `DesignKitHaptics`:

**Basic Haptics:**
```swift
DesignKitHaptics.impact(.light)      // Light impact
DesignKitHaptics.impact(.medium)     // Medium impact
DesignKitHaptics.impact(.heavy)      // Heavy impact
DesignKitHaptics.selection()         // Selection changed
DesignKitHaptics.notification(.success)  // Success
DesignKitHaptics.notification(.warning)  // Warning
DesignKitHaptics.notification(.error)    // Error
```

**Contextual Haptics:**
```swift
DesignKitHaptics.criticalAction()   // Heavy impact for important actions
DesignKitHaptics.standardAction()   // Medium impact for standard interactions
DesignKitHaptics.success()          // Success notification
DesignKitHaptics.warning()          // Warning notification
DesignKitHaptics.error()            // Error notification
```

Example:
```swift
Button("Delete") {
    DesignKitHaptics.criticalAction()
    performDelete()
}
.primaryButton(isDestructive: true)
```

### Icon System

Curated SF Symbols collection via `DesignKitIcons`:

**Alarm States:**
```swift
DesignKitIcons.alarmScheduled    // "alarm"
DesignKitIcons.alarmRunning      // "alarm.fill"
DesignKitIcons.alarmPaused       // "pause.circle.fill"
DesignKitIcons.alarmAlerting     // "bell.badge.fill"
```

**Actions:**
```swift
DesignKitIcons.add        // "plus.circle.fill"
DesignKitIcons.delete     // "trash.fill"
DesignKitIcons.edit       // "pencil"
DesignKitIcons.settings   // "gearshape.fill"
DesignKitIcons.close      // "xmark"
DesignKitIcons.checkmark  // "checkmark"
```

**Time/Schedule:**
```swift
DesignKitIcons.calendar   // "calendar"
DesignKitIcons.clock      // "clock.fill"
DesignKitIcons.timer      // "timer"
DesignKitIcons.repeat     // "repeat"
```

**Status Indicators:**
```swift
DesignKitIcons.warning    // "exclamationmark.triangle.fill"
DesignKitIcons.error      // "xmark.circle.fill"
DesignKitIcons.success    // "checkmark.circle.fill"
DesignKitIcons.info       // "info.circle.fill"
```

Example:
```swift
Image(systemName: DesignKitIcons.alarmRunning)
    .foregroundColor(DesignKit.running)
```

### View Modifiers

**Card Modifier:**
```swift
VStack {
    Text("Card Content")
}
.padding(DesignKit.lg)
.card()
```
- Applies surface background color
- Adds corner radius (16pt)
- Adds subtle shadow
- Automatically adapts to color scheme

**Status Badge Modifier:**
```swift
Text("Active")
    .statusBadge(color: DesignKit.success)

Text("Paused")
    .statusBadge(color: DesignKit.paused)
```
- Uppercase text
- 14pt semibold font
- White text on colored background
- Tight padding with 4pt corner radius

## Complete Example

```swift
import SwiftUI
import DesignKit

struct AlarmCard: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false

    var body: some View {
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
        .card()
    }
}
```

## Platform Support

- iOS 17.0+
- macOS 13.0+
- Mac Catalyst 15.0+

## Requirements

- Swift 5.9+
- Xcode 15.0+

## Architecture

DesignKit is organized into the following modules:

```
DesignKit/
├── Configuration/          # Configuration structs
│   ├── DesignKitConfiguration.swift
│   ├── ColorConfiguration.swift
│   └── TypographyConfiguration.swift
├── API/                   # Core design tokens
│   ├── Colors.swift
│   ├── Typography.swift
│   ├── Spacing.swift
│   ├── Animations.swift
│   ├── Shadows.swift
│   └── Radius.swift
├── Components/            # Reusable components
│   ├── ButtonStyles.swift
│   ├── Haptics.swift
│   ├── Icons.swift
│   └── ViewModifiers.swift
├── Molecules/             # Production-ready UI components
│   ├── DSButton.swift
│   ├── DSCard.swift
│   ├── NavBarHeader.swift
│   ├── SearchBar.swift
│   ├── MenuListItem.swift
│   ├── TextFieldItem.swift
│   ├── InputFieldItems.swift
│   ├── DatePickerItem.swift
│   ├── ColorPickerItem.swift
│   └── SuccessNotification.swift
└── DesignKit.swift       # Main framework entry point
```

## Best Practices

1. **Always configure DesignKit** at app launch before any views are rendered
2. **Use semantic colors** (success, warning, danger) instead of direct color values for better consistency
3. **Leverage spacing tokens** instead of hardcoded values for maintainable layouts
4. **Apply animations** to state changes for polished user experiences
5. **Use haptic feedback** to reinforce user actions and provide tactile feedback
6. **Prefer View extensions** (`.largeTitle()`) over direct font calls for cleaner code
7. **Use the liquidGlassGradient** for beautiful background that automatically adapts to dark mode
8. **Leverage molecule components** for consistent, production-ready UI elements with built-in validation and state management

## License

MIT License - See LICENSE file for details

## Version

Current version: 1.1.0

### What's New in 1.1.0

- **Molecule Components**: Added production-ready UI components including:
  - DSButton & HealthIconButton for modern button interfaces
  - DSCard for informational cards
  - NavBarHeader for navigation headers
  - SearchBar for search functionality
  - MenuListItem for rich list items
  - TextFieldItem, MenuPickerItem, DatePickerItem, ColorPickerItem, and ToggleItem for form inputs
  - SuccessNotification for animated success states
