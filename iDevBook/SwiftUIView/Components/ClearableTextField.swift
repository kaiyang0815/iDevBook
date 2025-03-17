//
// ClearableTextField.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

struct ClearableTextField: View {
    var placeholder: String
    @Binding var text: String

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(placeholder, text: $text)
                .padding(.trailing, 20)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}

#Preview {
    @Previewable
    @State var inputStirng: String = ""
    Form {
        ClearableTextField("placeholder", text: $inputStirng)
    }
}
