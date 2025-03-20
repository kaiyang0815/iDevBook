//
// WithDescriptionView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

struct WithDescriptionView<Content: View>: View {
    @Binding var showDescription: Bool
    let description: String
    let content: () -> Content

    var body: some View {
        VStack(alignment: .leading) {
            content()

            if showDescription {
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    WithDescriptionView(showDescription: .constant(true), description: "description") {
        Text("MainView")
    }
}
