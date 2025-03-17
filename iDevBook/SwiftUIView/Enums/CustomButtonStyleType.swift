//
// ButtonStyleType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum CustomButtonStyleType: String, CaseIterable, Identifiable {
    case automatic
    case bordered
    case borderedProminent
    case borderless
    case plain

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "Automatic"
        case .bordered:
            "Bordered"
        case .borderedProminent:
            "BorderedProminent"
        case .borderless:
            "BorderLess"
        case .plain:
            "Plain"
        }
    }
    
    var style: any PrimitiveButtonStyle {
        switch self {
        case .automatic:
                .automatic
        case .bordered:
                .bordered
        case .borderedProminent:
                .borderedProminent
        case .borderless:
                .borderless
        case .plain:
                .plain
        }
    }
}
