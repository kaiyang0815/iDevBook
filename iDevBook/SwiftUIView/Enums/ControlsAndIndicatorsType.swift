//
// ControlsAndIndicatorsType.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum ControlsAndIndicatorsType: String, CaseIterable, Identifiable {
    case button
    case editButton
    case pasteButton
    case renameButton
    case link
    case shareLink
    case sharePreview
    case textFieldLink
    case helpLink
    case slider
    case stepper
    case toggle
    case picker
    case datePicker
    case colorPicker
    case gauge
    case progressView
    case contentUnavailableView

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .button:
            "Button"
        case .editButton:
            "EditButton"
        case .pasteButton:
            "PasteButton"
        case .renameButton:
            "RenameButton"
        case .link:
            "Link"
        case .shareLink:
            "ShareLink"
        case .sharePreview:
            "SharePreview"
        case .textFieldLink:
            "TextFieldLink"
        case .helpLink:
            "HelpLink"
        case .slider:
            "Slider"
        case .stepper:
            "Stepper"
        case .toggle:
            "Toggle"
        case .picker:
            "Picker"
        case .datePicker:
            "DatePicker"
        case .colorPicker:
            "ColorPicker"
        case .gauge:
            "Gauge"
        case .progressView:
            "ProgressView"
        case .contentUnavailableView:
            "ContentUnavailableView"
        }
    }

    var description: String {
        switch self {
        case .button:
            "A control that initiates an action."
        case .editButton:
            "A button that toggles the edit mode environment value."
        case .pasteButton:
            "A system button that reads items from the pasteboard and delivers it to a closure."
        case .renameButton:
            "A button that triggers a standard rename action."
        case .link:
            "A control for navigating to a URL."
        case .shareLink:
            "A view that controls a sharing presentation."
        case .sharePreview:
            "A representation of a type to display in a share preview."
        case .textFieldLink:
            "A control that requests text input from the user when pressed."
        case .helpLink:
            "A button with a standard appearance that opens app-specific help documentation."
        case .slider:
            "A control for selecting a value from a bounded linear range of values."
        case .stepper:
            "A control that performs increment and decrement actions."
        case .toggle:
            "A control that toggles between on and off states."
        case .picker:
            "A control for selecting from a set of mutually exclusive values."
        case .datePicker:
            "A control for selecting an absolute date."
        case .colorPicker:
            "A control used to select a color from the system color picker UI."
        case .gauge:
            "A view that shows a value within a range."
        case .progressView:
            "A view that shows the progress toward completion of a task."
        case .contentUnavailableView:
            "An interface, consisting of a label and additional content, that you display when the content of your app is unavailable to users."
        }
    }
}
