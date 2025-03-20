//
// TextInputAndOutputType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum TextInputAndOutputType: String, CaseIterable, Identifiable {
    case text
    case label
    case textField
    case secureField
    case textEditor

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .text:
            "Text"
        case .label:
            "Label"
        case .textField:
            "TextField"
        case .secureField:
            "SecureField"
        case .textEditor:
            "TextEditor"
        }
    }

    var description: String {
        switch self {
        case .text:
            "A view that displays one or more lines of read-only text."
        case .label:
            "A standard label for user interface items, consisting of an icon with a title."
        case .textField:
            "A control that displays an editable text interface."
        case .secureField:
            "A control into which people securely enter private text."
        case .textEditor:
            "A view that can display and edit long-form text."
        }
    }
}
