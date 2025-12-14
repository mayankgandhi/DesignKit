//
//  DSCard.swift
//  WalnutDesignSystem
//
//  Created by Mayank Gandhi on 08/08/25.
//  Copyright © 2025 m. All rights reserved.
//

import SwiftUI

/// Knowledge base card (matching the "Got a question?" design)
public struct DSCard: View {
    private let title: String
    private let subtitle: String
    private let imageName: String
    private let backgroundColor: Color
    private let designKit: DesignKit
    
    public init(
        title: String,
        subtitle: String,
        imageName: String = "person.crop.circle.fill.badge.questionmark",
        backgroundColor: Color? = nil,
        designKit: DesignKit
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.backgroundColor = backgroundColor ?? designKit.primary
        self.designKit = designKit
    }
    
    public var body: some View {
        HStack(spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(title)
                    .subheadline(designKit)
                    .foregroundStyle(.white)

                Text(subtitle)
                    .caption(designKit)
                    .foregroundStyle(.white.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: imageName)
                .timeDisplay(designKit)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(Spacing.md)
        .background(backgroundColor, in: RoundedRectangle(cornerRadius: Radius.medium))
    }
}

#Preview {
    let designKit = DesignKit(.default)
    return DSCard(
        title: "Knowledge Card",
        subtitle: "Title",
        imageName: "calendar.badge",
        backgroundColor: .red,
        designKit: designKit
    )
    .padding(Spacing.md)
}
