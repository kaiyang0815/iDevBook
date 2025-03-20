//
// SpringAnimationType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum SpringAnimationType: String, CaseIterable, Identifiable {
    case type1
    case type2
    case type3

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .type1:
            "Type 1"
        case .type2:
            "Type 2"
        case .type3:
            "Type 3"
        }
    }
}
