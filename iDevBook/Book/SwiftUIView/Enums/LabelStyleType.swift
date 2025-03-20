//
// LabelStyleType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum LabelStyleType: String, CaseIterable, Identifiable {
    case automatic
    case iconOnly
    case titleAndIcon
    case titleOnly

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "automatic"
        case .iconOnly:
            "iconOnly"
        case .titleAndIcon:
            "titleAndIcon"
        case .titleOnly:
            "titleOnly"
        }
    }
}
