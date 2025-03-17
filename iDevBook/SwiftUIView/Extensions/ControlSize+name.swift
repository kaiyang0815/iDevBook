//
// ControlSize+.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

extension ControlSize {
    var name: String {
        switch self {
        case .mini:
            "Mini"
        case .small:
            "Small"
        case .regular:
            "Regular"
        case .large:
            "Large"
        case .extraLarge:
            "ExtraLarge"
        @unknown default:
            "Unknown"
        }
    }
}
