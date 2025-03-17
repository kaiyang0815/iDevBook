//
// TextFieldStyleType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum TextFieldStyleType: String, CaseIterable, Identifiable {
    case automatic
    case plain
    case roundedBorder
    case squareBorder

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "automatic"
        case .plain:
            "plain"
        case .roundedBorder:
            "roundedBorder"
        case .squareBorder:
            "squareBorder"
        }
    }
}
