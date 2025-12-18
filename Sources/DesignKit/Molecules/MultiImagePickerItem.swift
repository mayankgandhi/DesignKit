//
//  MultiImagePickerItem.swift
//  DesignKit
//
//  Created by Mayank Gandhi on 18/12/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI
import PhotosUI
#if os(iOS)
import UIKit

/// State for individual image slots in multi-image picker
public enum ImageSlotState: Equatable {
    case empty
    case selected(UIImage)
    case uploading(UIImage)
    case uploaded(UIImage, String)
    case error(UIImage?, String)

    public static func == (lhs: ImageSlotState, rhs: ImageSlotState) -> Bool {
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

    var hasImage: Bool {
        switch self {
        case .empty:
            return false
        default:
            return true
        }
    }

    var image: UIImage? {
        switch self {
        case .empty:
            return nil
        case .selected(let image), .uploading(let image), .uploaded(let image, _):
            return image
        case .error(let image, _):
            return image
        }
    }

    var uploadedURL: String? {
        if case .uploaded(_, let url) = self {
            return url
        }
        return nil
    }
}

/// Multi-image picker component with grid layout for product/gallery images
public struct MultiImagePickerItem: View {
    // MARK: - Configuration
    private let title: String
    private let maxImages: Int
    private let columns: Int
    private let helperText: String?
    private let designKit: DesignKit
    private let uploadService: ImageUploadService

    // MARK: - Bindings
    @Binding private var imageURLs: [String]

    // MARK: - Internal State
    @State private var slotStates: [ImageSlotState]
    @State private var selectedSlotIndex: Int?
    @State private var showingSourceSelection = false
    @State private var showingCamera = false
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var hapticCounter = 0

    // MARK: - Initialization
    public init(
        title: String,
        imageURLs: Binding<[String]>,
        maxImages: Int = 5,
        columns: Int = 3,
        helperText: String? = "Tap empty slot to add image, tap X to remove",
        uploadService: ImageUploadService = MockImageUploadService(),
        designKit: DesignKit
    ) {
        self.title = title
        self._imageURLs = imageURLs
        self.maxImages = maxImages
        self.columns = columns
        self.helperText = helperText
        self.uploadService = uploadService
        self.designKit = designKit

        // Initialize slot states
        self._slotStates = State(initialValue: Array(repeating: .empty, count: maxImages))
    }

    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: Spacing.sm), count: columns)
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Title
            Text(title)
                .title3(designKit)
                .foregroundStyle(.primary)

            // Image grid
            LazyVGrid(columns: gridColumns, spacing: Spacing.sm) {
                ForEach(0..<maxImages, id: \.self) { index in
                    ImageSlotView(
                        index: index,
                        state: slotStates[index],
                        isMainSlot: index == 0,
                        designKit: designKit,
                        onTap: {
                            handleSlotTap(at: index)
                        },
                        onRemove: {
                            removeImage(at: index)
                        },
                        onRetry: {
                            retryUpload(at: index)
                        }
                    )
                }
            }

            // Helper text
            if let helper = helperText, !helper.isEmpty {
                Text(helper)
                    .caption(designKit)
                    .foregroundStyle(.secondary)
            }
        }
        .sheet(isPresented: $showingSourceSelection) {
            sourceSelectionSheet
        }
        .sheet(isPresented: $showingCamera) {
            CameraPickerView(
                onImageSelected: { image in
                    if let index = selectedSlotIndex {
                        handleImageSelection(image, at: index)
                    }
                }
            )
        }
        .onChange(of: selectedPhotoItem) { _, newItem in
            Task {
                if let newItem = newItem,
                   let data = try? await newItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: data),
                   let index = selectedSlotIndex {
                    handleImageSelection(image, at: index)
                }
                selectedPhotoItem = nil
            }
        }
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: hapticCounter)
    }

    // MARK: - Slot Tap Handler
    private func handleSlotTap(at index: Int) {
        hapticCounter += 1
        selectedSlotIndex = index

        switch slotStates[index] {
        case .empty:
            showingSourceSelection = true
        case .uploaded, .selected, .error:
            showingSourceSelection = true
        case .uploading:
            break
        }
    }

    // MARK: - Image Selection Handler
    private func handleImageSelection(_ image: UIImage, at index: Int) {
        slotStates[index] = .selected(image)

        Task {
            await uploadImage(image, at: index)
        }
    }

    // MARK: - Upload Logic
    private func uploadImage(_ image: UIImage, at index: Int) async {
        await MainActor.run {
            slotStates[index] = .uploading(image)
        }

        do {
            let url = try await uploadService.uploadImage(image)

            await MainActor.run {
                slotStates[index] = .uploaded(image, url)
                updateImageURLs()
            }
        } catch {
            await MainActor.run {
                let errorMsg = (error as? ImageUploadError)?.errorDescription
                    ?? "Upload failed"
                slotStates[index] = .error(image, errorMsg)
            }
        }
    }

    private func retryUpload(at index: Int) {
        hapticCounter += 1
        guard case .error(let image, _) = slotStates[index], let image = image else {
            return
        }

        Task {
            await uploadImage(image, at: index)
        }
    }

    private func removeImage(at index: Int) {
        hapticCounter += 1
        slotStates[index] = .empty
        updateImageURLs()
    }

    private func updateImageURLs() {
        imageURLs = slotStates.compactMap { $0.uploadedURL }
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

                // Photo Library option
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

// MARK: - Image Slot View

private struct ImageSlotView: View {
    let index: Int
    let state: ImageSlotState
    let isMainSlot: Bool
    let designKit: DesignKit
    let onTap: () -> Void
    let onRemove: () -> Void
    let onRetry: () -> Void

    @State private var isPressed = false

    private var slotSize: CGFloat {
        // Approximate size for responsive grid
        (UIScreen.main.bounds.width - Spacing.lg * 2 - Spacing.sm * 2) / 3
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Main slot content
            slotContent
                .frame(height: slotSize)
                .clipShape(RoundedRectangle(cornerRadius: Radius.medium))
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.medium)
                        .stroke(strokeColor, lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.97 : 1.0)
                .animation(Animation.quick, value: isPressed)
                .onTapGesture {
                    onTap()
                }
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
                    isPressed = pressing
                })

            // Remove button (only show when has image)
            if state.hasImage {
                removeButton
            }

            // Main badge (only for first slot when it has image)
            if isMainSlot && state.hasImage {
                mainBadge
            }
        }
    }

    @ViewBuilder
    private var slotContent: some View {
        switch state {
        case .empty:
            emptySlotView

        case .selected(let image):
            imageView(image, showProgress: false)

        case .uploading(let image):
            imageView(image, showProgress: true)

        case .uploaded(let image, _):
            imageView(image, showProgress: false)

        case .error(let image, _):
            errorSlotView(image: image)
        }
    }

    private var emptySlotView: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGray6))

            Circle()
                .fill(Color(.systemTeal).opacity(0.7))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "plus")
                        .font(designKit.customSize(20, weight: .medium, relativeTo: .body))
                        .foregroundStyle(.white)
                )
        }
    }

    private func imageView(_ image: UIImage, showProgress: Bool) -> some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .opacity(showProgress ? 0.5 : 1.0)

            if showProgress {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
            }
        }
    }

    private func errorSlotView(image: UIImage?) -> some View {
        ZStack {
            // Red background
            Rectangle()
                .fill(Color.red.opacity(0.15))

            // Image if available (dimmed)
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.3)
            }

            // Warning icon
            VStack(spacing: Spacing.xs) {
                Image(systemName: "exclamationmark.triangle")
                    .font(designKit.customSize(28, weight: .medium, relativeTo: .title2))
                    .foregroundStyle(.red.opacity(0.8))
            }
        }
    }

    private var removeButton: some View {
        Button(action: onRemove) {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 28, height: 28)
                    .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)

                Image(systemName: "xmark")
                    .font(designKit.customSize(12, weight: .bold, relativeTo: .caption))
                    .foregroundStyle(.primary)
            }
        }
        .offset(x: -Spacing.xs, y: Spacing.xs)
    }

    private var mainBadge: some View {
        VStack {
            Spacer()
            HStack {
                Text("Main")
                    .font(designKit.customSize(11, weight: .semibold, relativeTo: .caption2))
                    .foregroundStyle(.white)
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xxs)
                    .background(
                        Capsule()
                            .fill(Color(.systemTeal))
                    )
                    .padding(Spacing.xs)
                Spacer()
            }
        }
    }

    private var strokeColor: Color {
        switch state {
        case .error:
            return .red.opacity(0.4)
        default:
            return .gray.opacity(0.3)
        }
    }
}

// MARK: - Camera Picker View

private struct CameraPickerView: UIViewControllerRepresentable {
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
        let parent: CameraPickerView

        init(parent: CameraPickerView) {
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

#Preview("Multi Image Picker - Empty") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            MultiImagePickerItem(
                title: "Product Images",
                imageURLs: .constant([]),
                maxImages: 5,
                columns: 3,
                designKit: designKit
            )
            .padding(.horizontal)
        }
        .padding(.top, Spacing.lg)
    }
    .background(.gray.opacity(0.1))
}

#Preview("Multi Image Picker - With Error") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            Text("Product Images")
                .title3(designKit)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Text("Note: Error state shown in first slot")
                .caption(designKit)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            MultiImagePickerItem(
                title: "Product Images",
                imageURLs: .constant(["https://example.com/1.jpg"]),
                maxImages: 5,
                columns: 3,
                designKit: designKit
            )
            .padding(.horizontal)
        }
        .padding(.top, Spacing.lg)
    }
    .background(.gray.opacity(0.1))
}

#Preview("Multi Image Picker - Gallery") {
    let designKit = DesignKit(.default)
    return ScrollView {
        VStack(spacing: Spacing.lg) {
            MultiImagePickerItem(
                title: "Gallery Photos",
                imageURLs: .constant([]),
                maxImages: 6,
                columns: 3,
                helperText: "Add up to 6 photos for your gallery",
                designKit: designKit
            )
            .padding(.horizontal)
        }
        .padding(.top, Spacing.lg)
    }
    .background(.gray.opacity(0.1))
}

#endif
