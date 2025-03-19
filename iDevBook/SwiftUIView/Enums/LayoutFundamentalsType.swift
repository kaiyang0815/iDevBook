//
// LayoutFundamentalsType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum LayoutFundamentalsType: String, CaseIterable, Identifiable {
    case hStack
    case vStack
    case zStack
    case lazyHStack
    case lazyVStack
    case grid
    case lazyHGrid
    case lazyVGrid
    case viewThatFits
    case spacer
    case divider

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .hStack:
            "HStack"
        case .vStack:
            "VStack"
        case .zStack:
            "ZStack"
        case .lazyHStack:
            "LazyHStack"
        case .lazyVStack:
            "LazyVStack"
        case .grid:
            "Grid"
        case .lazyHGrid:
            "LazyHGrid"
        case .lazyVGrid:
            "LazyVGrid"
        case .viewThatFits:
            "ViewThatFits"
        case .spacer:
            "Spacer"
        case .divider:
            "Divider"
        }
    }

    var description: String {
        switch self {
        case .hStack:
            "A view that arranges its subviews in a horizontal line."
        case .vStack:
            "A view that arranges its subviews in a vertical line."
        case .zStack:
            "A view that overlays its subviews, aligning them in both axes."
        case .lazyHStack:
            "A view that arranges its children in a line that grows horizontally, creating items only as needed."
        case .lazyVStack:
            "A view that arranges its children in a line that grows vertically, creating items only as needed."
        case .grid:
            "A container view that arranges other views in a two dimensional layout."
        case .lazyHGrid:
            "A container view that arranges its child views in a grid that grows horizontally, creating items only as needed."
        case .lazyVGrid:
            "A container view that arranges its child views in a grid that grows vertically, creating items only as needed."
        case .viewThatFits:
            "A view that adapts to the available space by providing the first child view that fits."
        case .spacer:
            "A flexible space that expands along the major axis of its containing stack layout, or on both axes if not contained in a stack."
        case .divider:
            "A visual element that can be used to separate other content."
        }
    }
}
