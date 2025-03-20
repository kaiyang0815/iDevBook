//
// ClearSectionModifier.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

struct ClearSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
    }
}

extension View {
    func clearSectionStyle() -> some View {
        self.modifier(ClearSectionModifier())
    }
}
