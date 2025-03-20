//
// GestureType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum GestureType: String, CaseIterable, Identifiable {
    case tapGesture
    case spatialTapGesture
    case longPressGesture
    case dragGesture
    case windowDragGesture
    case magnifyGesture
    case rotateGesture

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .tapGesture:
            "TapGesture"
        case .spatialTapGesture:
            "SpatialTapGesture"
        case .longPressGesture:
            "LongPressGesture"
        case .dragGesture:
            "DragGesture"
        case .windowDragGesture:
            "WindowDragGesture"
        case .magnifyGesture:
            "MagnifyGesture"
        case .rotateGesture:
            "RotateGestrure"
        }
    }

    var description: String {
        switch self {
        case .tapGesture:
            "A gesture that recognizes one or more taps."
        case .spatialTapGesture:
            "A gesture that recognizes one or more taps and reports their location."
        case .longPressGesture:
            "A gesture that succeeds when the user performs a long press."
        case .dragGesture:
            "A dragging motion that invokes an action as the drag-event sequence changes."
        case .windowDragGesture:
            "A gesture that recognizes the motion of and handles dragging a window."
        case .magnifyGesture:
            "A gesture that recognizes a magnification motion and tracks the amount of magnification."
        case .rotateGesture:
            "A gesture that recognizes a rotation motion and tracks the angle of the rotation."
        }
    }
}
