//
// EButtonBorderShape.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum EButtonBorderShape: String, CaseIterable, Identifiable {
    case automatic
    case capsule
    case circle
    case roundedRectangle

    var id: Self {
        return self
    }

    var style: ButtonBorderShape {
        switch self {
        case .automatic:
            .automatic
        case .capsule:
            .capsule
        case .circle:
            .circle
        case .roundedRectangle:
            .roundedRectangle
        }
    }

    var name: String {
        switch self {
        case .automatic:
            ".automatic"
        case .capsule:
            ".capsule"
        case .circle:
            ".circle"
        case .roundedRectangle:
            ".roundedRectangle"
        }
    }
}
