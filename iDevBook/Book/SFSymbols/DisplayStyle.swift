//
// DisplayStyle.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum DisplayStyle: String, CaseIterable, Identifiable {
    case grid
    case list
    case gallery

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .grid:
            "Grid"
        case .list:
            "List"
        case .gallery:
            "Gallery"
        }
    }

    var symbol: String {
        switch self {
        case .grid:
            "square.grid.2x2"
        case .list:
            "list.bullet"
        case .gallery:
            "rectangle.grid.3x1"
        }
    }
}
