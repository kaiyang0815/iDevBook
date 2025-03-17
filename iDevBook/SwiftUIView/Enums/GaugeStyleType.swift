//
// GaugeStyleType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum GaugeStyleType: String, CaseIterable, Identifiable {
    case automatic
    case circular
    case linear

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "Automatic"
        case .circular:
            "Circular"
        case .linear:
            "Linear"
        }
    }
}

enum ProgressViewStyleType: String, CaseIterable, Identifiable {
    case automatic
    case circular
    case linear

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "Automatic"
        case .circular:
            "Circular"
        case .linear:
            "Linear"
        }
    }
}
