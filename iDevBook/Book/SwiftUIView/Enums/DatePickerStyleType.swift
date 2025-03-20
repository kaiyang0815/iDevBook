//
// DatePickerStyleType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum DatePickerStyleType: String, CaseIterable, Identifiable {
    case automatic
    case compact
    case field
    case graphical
    case stepperField
    case wheel

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "Automatic"
        case .compact:
            "Compact"
        case .field:
            "Field"
        case .graphical:
            "Graphical"
        case .stepperField:
            "StepperField"
        case .wheel:
            "Wheel"
        }
    }
}
