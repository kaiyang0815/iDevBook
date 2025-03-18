//
// CardContainerView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI

struct CardContainerView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            // outer radius = inner radius + padding
            RoundedRectangle(cornerRadius: 16)
                .fill(backgroundColor)
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThickMaterial)
                .padding(6)
            content
                .padding(20)
        }
    }

    private var backgroundColor: Color {
        #if os(macOS)
        return Color(NSColor.windowBackgroundColor)
        #else
        return Color(UIColor.secondarySystemGroupedBackground)
        #endif
    }
}


#Preview {
    Form {
        Section {
            CardContainerView {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.orange)
                    .padding(20)
            }
        }
        .clearSectionStyle()
    }
}
