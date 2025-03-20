//
// PickerContainer.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

struct PickerContainer<
    T: Hashable & CaseIterable & Identifiable, Content: View
>: View where T.AllCases: RandomAccessCollection {
    let title: String
    @Binding var selection: T
    let content: (T) -> Content

    init(
        _ title: String, selection: Binding<T>,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.title = title
        self._selection = selection
        self.content = content
    }

    var body: some View {
        Picker(title, selection: $selection) {
            ForEach(T.allCases) { option in
                content(option)
                    .tag(option)
            }
        }
    }
}
