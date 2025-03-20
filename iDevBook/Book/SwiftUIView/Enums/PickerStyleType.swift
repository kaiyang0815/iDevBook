//
// PickerStyleType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum PickerStyleType: String, CaseIterable, Identifiable {
    case automatic
    case inline
    case menu
    case navigationLink
    case palette
    case radioGroup
    case segmented
    case wheel

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "Automatic"
        case .inline:
            "Inline"
        case .menu:
            "Menu"
        case .navigationLink:
            "navigationLink"
        case .palette:
            "palette"
        case .radioGroup:
            "radioGroup"
        case .segmented:
            "Segmented"
        case .wheel:
            "Wheel"
        }
    }
}
