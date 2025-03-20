//
// DatePickerMode.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum DatePickerMode: String, CaseIterable, Identifiable {
    case dateOnly = "Date only"
    case timeOnly = "Time only"
    case dateAndTime = "Date and Time"

    var id: Self { self }

    var components: DatePickerComponents {
        switch self {
        case .dateOnly:
            return [.date]
        case .timeOnly:
            return [.hourAndMinute]
        case .dateAndTime:
            return [.date, .hourAndMinute]
        }
    }
}
