import SwiftUI
import DesignKit

struct MoleculesExampleView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var fullName = ""
    @State private var email = ""
    @State private var selectedBloodType: String? = nil
    @State private var selectedDate: Date? = nil
    @State private var selectedColor = "#FF6B6B"
    @State private var notificationsEnabled = true

    var body: some View {
        ScrollView {
            VStack(spacing: DesignKit.xl) {
                // Search Bar
                sectionView(title: "Search Bar") {
                    SearchBar(
                        searchText: $searchText,
                        placeholder: "Search molecules..."
                    )
                }

                // Cards
                sectionView(title: "Cards") {
                    VStack(spacing: DesignKit.md) {
                        DSCard(
                            title: "Getting Started",
                            subtitle: "Learn the basics",
                            imageName: "book.fill",
                            backgroundColor: DesignKit.primary
                        )

                        DSCard(
                            title: "Knowledge Base",
                            subtitle: "Browse documentation",
                            imageName: "doc.text.fill",
                            backgroundColor: DesignKit.success
                        )
                    }
                }

                // Buttons
                sectionView(title: "Buttons") {
                    VStack(spacing: DesignKit.md) {
                        DSButton("Primary Action", style: .primary) {
                            print("Primary tapped")
                        }

                        DSButton("Secondary Action", style: .secondary) {
                            print("Secondary tapped")
                        }

                        DSButton("Delete", style: .destructive, icon: "trash") {
                            print("Delete tapped")
                        }

                        HStack(spacing: DesignKit.md) {
                            HealthIconButton(icon: "heart.fill", style: .primary) {
                                print("Heart tapped")
                            }
                            HealthIconButton(icon: "plus", style: .secondary) {
                                print("Plus tapped")
                            }
                            HealthIconButton(icon: "gear", style: .secondary) {
                                print("Settings tapped")
                            }
                        }
                    }
                }

                // Menu List Items
                sectionView(title: "Menu List Items") {
                    VStack(spacing: DesignKit.xs) {
                        MenuListItem(
                            icon: "book.fill",
                            title: "Diary",
                            subtitle: "Track your daily entries",
                            iconColor: DesignKit.primary,
                            badge: 3
                        )

                        MenuListItem(
                            icon: "leaf.fill",
                            title: "Nutrition",
                            subtitle: "Manage your meal plans",
                            iconColor: .green
                        )

                        MenuListItem(
                            icon: "chart.line.uptrend.xyaxis",
                            title: "Analytics",
                            subtitle: "View trends and insights",
                            iconColor: .blue
                        )
                    }
                }

                // Text Fields
                sectionView(title: "Text Fields") {
                    VStack(spacing: DesignKit.md) {
                        TextFieldItem(
                            icon: "person.fill",
                            title: "Full Name",
                            text: $fullName,
                            placeholder: "Enter your full name",
                            helperText: "This will be displayed on your profile",
                            isRequired: true
                        )

                        TextFieldItem(
                            icon: "envelope.fill",
                            title: "Email Address",
                            text: $email,
                            placeholder: "Enter your email",
                            iconColor: .blue,
                            keyboardType: .emailAddress,
                            contentType: .emailAddress
                        )
                    }
                }

                // Menu Picker
                sectionView(title: "Menu Picker") {
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
                }

                // Date Picker
                sectionView(title: "Date Picker") {
                    DatePickerItem(
                        icon: "calendar",
                        title: "Date of Birth",
                        selectedDate: $selectedDate,
                        helperText: "Used for age calculations",
                        iconColor: .blue,
                        isRequired: true
                    )
                }

                // Color Picker
                sectionView(title: "Color Picker") {
                    ColorPickerItem(
                        icon: "paintpalette.fill",
                        title: "Theme Color",
                        selectedColorHex: $selectedColor,
                        helperText: "Choose your profile theme color"
                    )
                }

                // Toggle
                sectionView(title: "Toggle Items") {
                    VStack(spacing: DesignKit.md) {
                        ToggleItem(
                            icon: "bell.fill",
                            title: "Notifications",
                            subtitle: "Get notified about important updates",
                            isOn: $notificationsEnabled,
                            helperText: "Push notifications will be sent to your device",
                            iconColor: .orange
                        )
                    }
                }

                // Success Notification
                sectionView(title: "Success Notification") {
                    SuccessNotification(
                        message: "Success!",
                        timestamp: "Just now",
                        value: "120",
                        unit: "mg/dL",
                        status: "Normal range"
                    )
                }

                // Nav Bar Header
                sectionView(title: "Navigation Header") {
                    NavBarHeader(
                        icon: "pills.fill",
                        iconColor: DesignKit.primary,
                        title: "Medications",
                        subtitle: "Manage your prescriptions"
                    )
                }
            }
            .padding(DesignKit.lg)
        }
        .background(DesignKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Molecules")
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
}

#Preview {
    NavigationStack {
        MoleculesExampleView()
    }
}
