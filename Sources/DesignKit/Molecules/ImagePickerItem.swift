//
//  ImagePickerItem.swift
//  DesignKit
//
//  Created by Mayank Gandhi on 15/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI
import PhotosUI
#if os(iOS)
import UIKit

/// Image picker component with upload functionality and TextFieldItem-inspired design
public struct ImagePickerItem: View {
    // MARK: - Configuration
    private let icon: String?
    private let title: String
    private let helperText: String?
    private let errorMessage: String?
    private let iconColor: Color
    private let isRequired: Bool
    private let designKit: DesignKit
    private let uploadService: ImageUploadService

    // MARK: - Bindings
    @Binding private var imageURL: String?

    // MARK: - Internal State
    @State private var pickerState: ImagePickerState = .empty
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showingCamera = false
    @State private var showingSourceSelection = false
    @State private var isPressed = false
    @State private var hapticCounter = 0

    // MARK: - State Machine
    private enum ImagePickerState: Equatable {
        case empty
        case selected(UIImage)
        case uploading(UIImage)
        case uploaded(UIImage, String)
        case error(UIImage?, String)

        static func == (lhs: ImagePickerState, rhs: ImagePickerState) -> Bool {
            switch (lhs, rhs) {
            case (.empty, .empty):
                return true
            case (.selected, .selected):
                return true
            case (.uploading, .uploading):
                return true
            case (.uploaded(_, let url1), .uploaded(_, let url2)):
                return url1 == url2
            case (.error(_, let msg1), .error(_, let msg2)):
                return msg1 == msg2
            default:
                return false
            }
        }
    }

    // MARK: - Validation State
    private var validationState: ValidationState {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error
        }
        if case .error = pickerState {
            return .error
        }
        if case .uploaded = pickerState {
            return .success
        }
        if isRequired && imageURL == nil {
            return .warning
        }
        return .normal
    }

    private enum ValidationState {
        case normal, success, warning, error

        var color: Color {
            switch self {
            case .normal: return .gray.opacity(0.3)
            case .success: return .green.opacity(0.7)
            case .warning: return .orange.opacity(0.8)
            case .error: return .red.opacity(0.8)
            }
        }

        var iconName: String {
            switch self {
            case .normal: return ""
            case .success: return "checkmark.circle.fill"
            case .warning: return "exclamationmark.circle.fill"
            case .error: return "xmark.circle.fill"
            }
        }
    }

    // MARK: - Initialization
    public init(
        icon: String? = nil,
        title: String,
        imageURL: Binding<String?>,
        helperText: String? = nil,
        errorMessage: String? = nil,
        iconColor: Color? = nil,
        isRequired: Bool = false,
        uploadService: ImageUploadService = MockImageUploadService(),
        designKit: DesignKit
    ) {
        self.icon = icon
        self.title = title
        self._imageURL = imageURL
        self.helperText = helperText
        self.errorMessage = errorMessage
        self.iconColor = iconColor ?? designKit.primary
        self.isRequired = isRequired
        self.uploadService = uploadService
        self.designKit = designKit
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            // Main image picker container
            HStack(spacing: Spacing.md) {
                // Icon section
                if let icon = icon {
                    iconView
                }

                // Content section
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    // Title with required indicator
                    HStack(spacing: Spacing.xxs) {
                        Text(title)
                            .footnote(designKit)
                            .foregroundStyle(.secondary)

                        if isRequired {
                            Text("*")
                                .footnote(designKit)
                                .foregroundStyle(.red.opacity(0.7))
                        }

                        Spacer()

                        // Validation icon
                        if !validationState.iconName.isEmpty && validationState != .normal {
                            Image(systemName: validationState.iconName)
                                .caption(designKit)
                                .foregroundStyle(validationState.color)
                        }
                    }

                    // Image content based on state
                    imageContentView
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm + 4)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: Radius.medium))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.medium)
                    .stroke(strokeColor, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.99 : 1.0)
            .animation(Animation.quick, value: isPressed)
            .shadow(
                color: Shadow.subtle.color,
                radius: Shadow.subtle.radius,
                x: Shadow.subtle.x,
                y: Shadow.subtle.y
            )
            .onTapGesture {
                hapticCounter += 1
                handleTap()
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: hapticCounter)
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                isPressed = pressing
            })
            .sheet(isPresented: $showingSourceSelection) {
                sourceSelectionSheet
            }
            .sheet(isPresented: $showingCamera) {
                CameraPickerViewController(
                    onImageSelected: { image in
                        handleImageSelection(image)
                    }
                )
            }
            .onChange(of: selectedPhotoItem) { _, newItem in
                Task {
                    if let newItem = newItem,
                       let data = try? await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        handleImageSelection(image)
                    }
                }
            }

            // Helper text or error message
            if let message = errorMessage, !message.isEmpty {
                Text(message)
                    .caption(designKit)
                    .foregroundStyle(.red.opacity(0.8))
                    .padding(.horizontal, Spacing.md)
            } else if let helper = helperText, !helper.isEmpty {
                Text(helper)
                    .caption(designKit)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, Spacing.md)
            }
        }
    }

    // MARK: - State-Based Content Views
    @ViewBuilder
    private var imageContentView: some View {
        switch pickerState {
        case .empty:
            emptyStateView

        case .selected(let image):
            selectedStateView(image)

        case .uploading(let image):
            uploadingStateView(image)

        case .uploaded(let image, _):
            uploadedStateView(image)

        case .error(let image, let message):
            errorStateView(image, message: message)
        }
    }

    private var emptyStateView: some View {
        HStack {
            Text("Tap to select image")
                .body(designKit)
                .foregroundStyle(.secondary)

            Spacer()
        }
    }

    private func selectedStateView(_ image: UIImage) -> some View {
        HStack(spacing: Spacing.sm) {
            // Compact image thumbnail
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: Radius.small))
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.small)
                        .stroke(.gray.opacity(0.2), lineWidth: 1)
                )

            Text("Ready to upload")
                .body(designKit)
                .foregroundStyle(.secondary)

            Spacer()
        }
    }

    private func uploadingStateView(_ image: UIImage) -> some View {
        HStack(spacing: Spacing.sm) {
            // Compact image thumbnail with progress
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.small))
                    .opacity(0.5)

                ProgressView()
                    .tint(designKit.primary)
                    .scaleEffect(0.8)
            }

            Text("Uploading...")
                .body(designKit)
                .foregroundStyle(.primary)

            Spacer()
        }
    }

    private func uploadedStateView(_ image: UIImage) -> some View {
        HStack(spacing: Spacing.sm) {
            // Compact image thumbnail
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: Radius.small))
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.small)
                        .stroke(.gray.opacity(0.2), lineWidth: 1)
                )

            Text("Image uploaded")
                .body(designKit)
                .foregroundStyle(.primary)

            Spacer()

            // Inline remove button
            Button {
                removeImage()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.secondary)
                    .font(designKit.customSize(18, weight: .medium, relativeTo: .body))
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.4), trigger: pickerState)
        }
    }

    private func errorStateView(_ image: UIImage?, message: String) -> some View {
        HStack(spacing: Spacing.sm) {
            // Compact image thumbnail (if available)
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.small))
                    .opacity(0.4)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.small)
                            .stroke(.red.opacity(0.3), lineWidth: 1)
                    )
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("Upload failed")
                    .body(designKit)
                    .foregroundStyle(.primary)

                Text(message)
                    .caption(designKit)
                    .foregroundStyle(.red.opacity(0.8))
                    .lineLimit(1)
            }

            Spacer()

            // Inline retry button
            Button {
                retryUpload()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .foregroundStyle(designKit.primary)
                    .font(designKit.customSize(18, weight: .medium, relativeTo: .body))
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: pickerState)

            // Inline cancel button
            Button {
                cancelAndReset()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.secondary)
                    .font(designKit.customSize(18, weight: .medium, relativeTo: .body))
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.4), trigger: pickerState)
        }
    }

    // MARK: - Icon View
    private var iconView: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            iconColor.opacity(0.08),
                            iconColor.opacity(0.12)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

            Circle()
                .stroke(iconColor.opacity(0.12), lineWidth: 1)
                .frame(width: Spacing.tapTargetMin, height: Spacing.tapTargetMin)

            Image(systemName: icon!)
                .tickerTitle(designKit)
                .foregroundStyle(iconColor.opacity(0.8))
        }
    }

    // MARK: - Background & Styling
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: Radius.medium)
            .fill(isPressed ? .gray.opacity(0.7) : .white.opacity(0.95))
    }

    private var strokeColor: Color {
        if validationState == .error {
            return .red.opacity(0.4)
        } else if validationState == .warning && isRequired && imageURL == nil {
            return .orange.opacity(0.4)
        } else {
            return .gray.opacity(0.6)
        }
    }

    // MARK: - Upload Logic
    private func handleTap() {
        switch pickerState {
        case .empty:
            showingSourceSelection = true
        case .uploaded:
            showingSourceSelection = true
        case .uploading:
            break
        case .selected, .error:
            showingSourceSelection = true
        }
    }

    private func handleImageSelection(_ image: UIImage) {
        pickerState = .selected(image)

        // Automatically trigger upload
        Task {
            await uploadImage(image)
        }
    }

    private func uploadImage(_ image: UIImage) async {
        await MainActor.run {
            pickerState = .uploading(image)
        }

        do {
            let url = try await uploadService.uploadImage(image)

            await MainActor.run {
                pickerState = .uploaded(image, url)
                imageURL = url
            }
        } catch {
            await MainActor.run {
                let errorMsg = (error as? ImageUploadError)?.errorDescription
                    ?? "Upload failed. Please try again."
                pickerState = .error(image, errorMsg)
            }
        }
    }

    private func retryUpload() {
        guard case .error(let image, _) = pickerState, let image = image else {
            return
        }

        Task {
            await uploadImage(image)
        }
    }

    private func removeImage() {
        pickerState = .empty
        imageURL = nil
    }

    private func cancelAndReset() {
        pickerState = .empty
        imageURL = nil
    }

    // MARK: - Source Selection Sheet
    private var sourceSelectionSheet: some View {
        NavigationView {
            VStack(spacing: Spacing.lg) {
                // Camera option
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    sourceOptionButton(
                        icon: "camera.fill",
                        title: "Take Photo",
                        subtitle: "Use your camera",
                        action: {
                            showingSourceSelection = false
                            showingCamera = true
                        }
                    )
                }

                // Photo Library option using PhotosPicker
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    sourceOptionContent(
                        icon: "photo.on.rectangle.angled",
                        title: "Choose from Library",
                        subtitle: "Select from your photos"
                    )
                }
                .buttonStyle(.plain)
                .onChange(of: selectedPhotoItem) { _, _ in
                    showingSourceSelection = false
                }

                Spacer()
            }
            .padding(Spacing.lg)
            .navigationTitle("Select Image Source")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showingSourceSelection = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }

    private func sourceOptionButton(
        icon: String,
        title: String,
        subtitle: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            sourceOptionContent(icon: icon, title: title, subtitle: subtitle)
        }
    }

    private func sourceOptionContent(
        icon: String,
        title: String,
        subtitle: String
    ) -> some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                designKit.primary.opacity(0.08),
                                designKit.primary.opacity(0.12)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)

                Image(systemName: icon)
                    .font(designKit.customSize(24, weight: .medium, relativeTo: .title2))
                    .foregroundStyle(designKit.primary)
            }

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(title)
                    .body(designKit)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .caption(designKit)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .caption(designKit)
                .foregroundStyle(.tertiary)
        }
        .padding(Spacing.md)
        .background(.ultraThinMaterial)
        .cornerRadius(Radius.medium)
    }
}

// MARK: - Camera Picker UIViewControllerRepresentable

private struct CameraPickerViewController: UIViewControllerRepresentable {
    let onImageSelected: (UIImage) -> Void
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPickerViewController

        init(parent: CameraPickerViewController) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImageSelected(image)
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

// MARK: - Previews

#Preview("Empty State") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Image Picker - Empty State")
                .title2(designKit)
                .padding(.horizontal)

            ImagePickerItem(
                icon: "photo.fill",
                title: "Profile Photo",
                imageURL: .constant(nil),
                helperText: "Upload a profile picture",
                iconColor: .blue,
                isRequired: true,
                designKit: designKit
            )
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

#Preview("Required Warning") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Image Picker - Required Warning")
                .title2(designKit)
                .padding(.horizontal)

            ImagePickerItem(
                icon: "person.crop.circle",
                title: "Avatar Image",
                imageURL: .constant(nil),
                helperText: "This field is required",
                iconColor: .purple,
                isRequired: true,
                designKit: designKit
            )
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

#Preview("Error State") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Image Picker - Error")
                .title2(designKit)
                .padding(.horizontal)

            ImagePickerItem(
                icon: "photo.fill",
                title: "Cover Image",
                imageURL: .constant(nil),
                errorMessage: "Image upload is required for this profile",
                iconColor: .red,
                designKit: designKit
            )
            .padding(.horizontal)
        }
    }
    .background(.gray.opacity(0.1))
}

#endif
