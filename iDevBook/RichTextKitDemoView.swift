//
// RichTextKitDemoView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import RichTextKit
import SwiftUI

struct RichTextKitDemoView: View {
    @State
    private var text = NSAttributedString(string: "Type text here...")
    // You can also load attributed strings from data, documents, etc.

    @StateObject
    var context = RichTextContext()

    var body: some View {
        RichTextEditor(text: $text, context: context) {
            $0.textContentInset = CGSize(width: 30, height: 30)
        }
        .focusedValue(\.richTextContext, context)
        #if os(iOS)
            RichTextKeyboardToolbar(
                context: context,
                leadingButtons: { $0 },
                trailingButtons: { $0 },
                formatSheet: { $0 }
            )
        #endif
    }
}

#Preview {
    RichTextKitDemoView()
}
