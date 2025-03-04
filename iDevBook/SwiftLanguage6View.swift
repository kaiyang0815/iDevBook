//
// SwiftLanguage6View.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import HighlightSwift
import SwiftUI

struct SwiftLanguage6View: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Function and Closures") {
                    FunctionandClosuresView()
                }
            }
            .navigationTitle("Swift 6")
        }
    }
}

#Preview {
    SwiftLanguage6View()
}
