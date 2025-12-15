import SwiftUI
import DesignKit

struct MoleculesExampleView: View {
    let designKit: DesignKit
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var fullName = ""
    @State private var email = ""
    @State private var selectedBloodType: String? = nil
    @State private var selectedDate: Date? = nil
    @State private var selectedColor = "#FF6B6B"
    @State private var notificationsEnabled = true
    @State private var profileImageURL: String? = nil
    @State private var productDescription = ""
    @State private var notes = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // Search Bar
                sectionView(title: "Search Bar") {
                    SearchBar(
                        searchText: $searchText,
                        placeholder: "Search molecules...",
                        designKit: designKit
                    )
                }
                
                // Cards
                sectionView(title: "Cards") {
                    VStack(spacing: Spacing.md) {
                        DSCard(
                            title: "Getting Started",
                            subtitle: "Learn the basics",
                            imageName: "book.fill",
                            backgroundColor: designKit.primary,
                            designKit: designKit
                        )
                        
                        DSCard(
                            title: "Knowledge Base",
                            subtitle: "Browse documentation",
                            imageName: "doc.text.fill",
                            backgroundColor: designKit.success,
                            designKit: designKit
                        )
                    }
                }
                
                // Buttons
                sectionView(title: "Buttons") {
                    VStack(spacing: Spacing.md) {
                        DSButton("Primary Action", style: .primary, designKit: designKit) {
                            print("Primary tapped")
                        }
                        
                        DSButton("Secondary Action", style: .secondary, designKit: designKit) {
                            print("Secondary tapped")
                        }
                        
                        DSButton("Delete", style: .destructive, icon: "trash", designKit: designKit) {
                            print("Delete tapped")
                        }
                        
                        HStack(spacing: Spacing.md) {
                            HealthIconButton(icon: "heart.fill", style: .primary, designKit: designKit) {
                                print("Heart tapped")
                            }
                            HealthIconButton(icon: "plus", style: .secondary, designKit: designKit) {
                                print("Plus tapped")
                            }
                            HealthIconButton(icon: "gear", style: .secondary, designKit: designKit) {
                                print("Settings tapped")
                            }
                        }
                    }
                }
                
                // Menu List Items
                sectionView(title: "Menu List Items") {
                    VStack(spacing: Spacing.xs) {
                        MenuListItem(
                            icon: "book.fill",
                            title: "Diary",
                            subtitle: "Track your daily entries",
                            iconColor: designKit.primary,
                            badge: 3,
                            designKit: designKit
                        )
                        
                        MenuListItem(
                            icon: "leaf.fill",
                            title: "Nutrition",
                            subtitle: "Manage your meal plans",
                            iconColor: .green,
                            designKit: designKit
                        )
                        
                        MenuListItem(
                            icon: "chart.line.uptrend.xyaxis",
                            title: "Analytics",
                            subtitle: "View trends and insights",
                            iconColor: .blue,
                            designKit: designKit
                        )
                    }
                }
                
                // Text Fields
                sectionView(title: "Text Fields") {
                    VStack(spacing: Spacing.md) {
                        TextFieldItem(
                            icon: "person.fill",
                            title: "Full Name",
                            text: $fullName,
                            placeholder: "Enter your full name",
                            helperText: "This will be displayed on your profile",
                            isRequired: true,
                            designKit: designKit
                        )

                        TextFieldItem(
                            icon: "envelope.fill",
                            title: "Email Address",
                            text: $email,
                            placeholder: "Enter your email",
                            iconColor: .blue,
                            designKit: designKit,
                            keyboardType: .emailAddress,
                            contentType: .emailAddress
                        )
                    }
                }

                // Text Editor
                sectionView(title: "Text Editor") {
                    VStack(spacing: Spacing.md) {
                        TextEditorItem(
                            icon: "text.alignleft",
                            title: "Product Description",
                            text: $productDescription,
                            placeholder: "Enter a detailed product description...",
                            helperText: "Describe your product in detail",
                            characterLimit: 500,
                            iconColor: .blue,
                            isRequired: true,
                            designKit: designKit
                        )

                        TextEditorItem(
                            icon: "note.text",
                            title: "Additional Notes",
                            text: $notes,
                            placeholder: "Add any additional notes...",
                            helperText: "Optional notes or comments",
                            iconColor: .green,
                            designKit: designKit
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
                        isRequired: true,
                        designKit: designKit
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
                        isRequired: true,
                        designKit: designKit
                    )
                }
                
                // Color Picker
                sectionView(title: "Color Picker") {
                    ColorPickerItem(
                        icon: "paintpalette.fill",
                        title: "Theme Color",
                        selectedColorHex: $selectedColor,
                        helperText: "Choose your profile theme color",
                        designKit: designKit
                    )
                }

                // Image Picker
                #if os(iOS)
                sectionView(title: "Image Picker") {
                    ImagePickerItem(
                        icon: "photo.fill",
                        title: "Profile Photo",
                        imageURL: $profileImageURL,
                        helperText: "Upload a profile picture from your camera or photo library",
                        iconColor: .purple,
                        isRequired: true,
                        designKit: designKit
                    )
                }
                #endif

                // Toggle
                sectionView(title: "Toggle Items") {
                    VStack(spacing: Spacing.md) {
                        ToggleItem(
                            icon: "bell.fill",
                            title: "Notifications",
                            subtitle: "Get notified about important updates",
                            isOn: $notificationsEnabled,
                            helperText: "Push notifications will be sent to your device",
                            iconColor: .orange,
                            designKit: designKit
                        )
                    }
                }
                
                // Nav Bar Header
                sectionView(title: "Navigation Header") {
                    NavBarHeader(
                        icon: "pills.fill",
                        iconColor: designKit.primary,
                        title: "Medications",
                        subtitle: "Manage your prescriptions",
                        designKit: designKit
                    )
                }
            }
            .padding(Spacing.lg)
        }
        .background(designKit.liquidGlassGradient(for: colorScheme).ignoresSafeArea())
        .navigationTitle("Molecules")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func sectionView<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(title)
                .font(designKit.headline())
                .foregroundColor(designKit.textPrimary(for: colorScheme))
            
            content()
        }
        .padding(Spacing.lg)
        .card(designKit: designKit)
    }
}

#Preview {
    NavigationStack {
        MoleculesExampleView(designKit: DesignKit(DesignKitConfiguration.default))
    }
}
