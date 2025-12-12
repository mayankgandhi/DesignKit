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
    
    public init(
        title: String,
        subtitle: String,
        imageName: String = "person.crop.circle.fill.badge.questionmark",
        backgroundColor: Color = DesignKit.primary
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        HStack(spacing: DesignKit.md) {
            VStack(alignment: .leading, spacing: DesignKit.xs) {
                Text(title)
                    .subheadline()
                    .foregroundStyle(.white)

                Text(subtitle)
                    .caption()
                    .foregroundStyle(.white.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: imageName)
                .font(.system(size: 32))
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(DesignKit.md)
        .background(backgroundColor, in: RoundedRectangle(cornerRadius: DesignKit.radiusMedium))
    }
}

#Preview {
    DSCard(
        title: "Knowledge Card",
        subtitle: "Title",
        imageName: "calendar.badge",
        backgroundColor: .red
    )
    .padding(DesignKit.md)
}
