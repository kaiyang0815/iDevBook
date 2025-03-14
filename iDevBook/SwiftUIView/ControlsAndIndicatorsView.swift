//
//  ControlsAndIndicatorsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/31.
//
//

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
    case multiDatePicker
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
        case .multiDatePicker:
            "MultiDatePicker"
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
        case .multiDatePicker:
            "A control for picking multiple dates."
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

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

enum ButtonStyleType: String, CaseIterable, Identifiable {
    case automatic
    case bordered
    case borderedProminent
    case borderless
    case plain

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "Automatic"
        case .bordered:
            "Bordered"
        case .borderedProminent:
            "BorderedProminent"
        case .borderless:
            "BorderLess"
        case .plain:
            "Plain"
        }
    }
}

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

struct ControlsAndIndicatorsView: View {
    @State private var selectedCAITye: ControlsAndIndicatorsType =
        .button
    @State private var selectedFlavor: Flavor = .chocolate
    @State private var selectedPickerStyleType: PickerStyleType = .automatic
    @State private var selectedDatePickerStyleType: DatePickerStyleType =
        .automatic
    @State private var selectedGaugeStyleType: GaugeStyleType = .automatic
    @State private var selectedProgressViewStyleType: ProgressViewStyleType =
        .automatic
    @State private var selectedButtonStyleType: ButtonStyleType = .automatic
    @State private var selectedControlSize: ControlSize = .regular

    @State private var clickCount: Int = 0
    @State private var buttonRepeatBehavior: Bool = false
    @State private var pastedText: String = ""
    @State private var name = "Example Name"
    @State private var openedURL = ""
    @State private var sliderValue = 50.0
    @State private var isSliding = false
    @State private var sliderRange = 0.0...100.0
    @State private var sliderStep = 5.0
    @State private var stepperValue = 0
    @State private var stepperStep = 1
    @State private var toggleValue: Bool = false
    @State private var datePickerValue = Date.now
    @State private var colorPickerValue = Color.red
    @State private var supportsOpacity = true
    @State private var gaugeCurrentValue = 60.0
    @State private var gaugeMinValue = 0.0
    @State private var gaugeMaxValue = 100.0
    @State private var progressValue = 0.5
    @State private var progressTotal = 1.0

    @State private var showDescription: Bool = false
    @State private var hideTabBar: Bool = false

    @FocusState private var isFocused: Bool

    var listHeight: Double {
        switch selectedCAITye {
        case .button:
            100
        case .editButton:
            100
        case .pasteButton:
            100
        case .renameButton:
            100
        case .link:
            100
        case .shareLink:
            100
        case .sharePreview:
            100
        case .textFieldLink:
            100
        case .helpLink:
            100
        case .slider:
            100
        case .stepper:
            100
        case .toggle:
            100
        case .picker:
            100
        case .datePicker:
            120
        case .multiDatePicker:
            100
        case .colorPicker:
            100
        case .gauge:
            160
        case .progressView:
            160
        case .contentUnavailableView:
            260
        }
    }

    var body: some View {
        NavigationStack {
            #if os(iOS)
                VStack(spacing: 0) {
                    List {
                        Section("Preview") {
                            switch selectedCAITye {
                            case .button:
                                Group {
                                    switch selectedButtonStyleType {
                                    case .automatic:
                                        Button("Click") {
                                            withAnimation {
                                                clickCount += 1
                                            }
                                        }
                                        .buttonStyle(.automatic)
                                        .buttonRepeatBehavior(
                                            buttonRepeatBehavior
                                                ? .enabled : .disabled)
                                    case .bordered:
                                        Button("Click") {
                                            withAnimation {
                                                clickCount += 1
                                            }
                                        }
                                        .buttonStyle(.bordered)
                                        .buttonRepeatBehavior(
                                            buttonRepeatBehavior
                                                ? .enabled : .disabled)
                                    case .borderedProminent:
                                        Button("Click") {
                                            withAnimation {
                                                clickCount += 1
                                            }
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .buttonRepeatBehavior(
                                            buttonRepeatBehavior
                                                ? .enabled : .disabled)
                                    case .borderless:
                                        Button("Click") {
                                            withAnimation {
                                                clickCount += 1
                                            }
                                        }
                                        .buttonStyle(.borderless)
                                        .buttonRepeatBehavior(
                                            buttonRepeatBehavior
                                                ? .enabled : .disabled)
                                    case .plain:
                                        Button("Click") {
                                            withAnimation {
                                                clickCount += 1
                                            }
                                        }
                                        .buttonStyle(.plain)
                                        .buttonRepeatBehavior(
                                            buttonRepeatBehavior
                                                ? .enabled : .disabled)
                                    }
                                }
                                .controlSize(selectedControlSize)
                            case .editButton:
                                EditButton()
                            case .pasteButton:
                                PasteButton(payloadType: String.self) {
                                    strings in
                                    withAnimation {
                                        pastedText = strings[0]
                                    }
                                }
                            case .renameButton:
                                TextField("Enter new name", text: $name)
                                    .focused($isFocused)
                                RenameButton()
                                    .renameAction {
                                        withAnimation {
                                            self.name = ""
                                            self.isFocused = true
                                        }
                                    }
                            case .link:
                                Link(
                                    "Open URL",
                                    destination: URL(
                                        string: "https://www.example.com")!
                                )
                                .environment(
                                    \.openURL,
                                    OpenURLAction { url in
                                        withAnimation {
                                            self.openedURL = url.absoluteString
                                            return .handled
                                        }
                                    })
                            case .shareLink:
                                ShareLink(
                                    item: URL(
                                        string:
                                            "https://developer.apple.com/xcode/swiftui/"
                                    )!
                                ) {
                                    Label(
                                        "Share Link",
                                        systemImage: "square.and.arrow.up"
                                    )
                                }
                            case .sharePreview:
                                ShareLink(
                                    item: URL(
                                        string:
                                            "https://developer.apple.com/xcode/swiftui/"
                                    )!,
                                    preview: SharePreview(
                                        "SwiftUI",
                                        image: Image("SwiftUI"))
                                ) {
                                    Label(
                                        "Share Preview",
                                        systemImage: "square.and.arrow.up"
                                    )
                                }
                            case .textFieldLink:
                                Text("watchOS only")
                            case .helpLink:
                                Text("macOS only")
                            case .slider:
                                Slider(
                                    value: $sliderValue.animation(),
                                    in: sliderRange,
                                    step: sliderStep
                                ) {
                                    Text("Slider")
                                } minimumValueLabel: {
                                    Text(
                                        sliderRange.lowerBound, format: .number)
                                } maximumValueLabel: {
                                    Text(
                                        sliderRange.upperBound, format: .number)
                                } onEditingChanged: { editing in
                                    isSliding = editing
                                }
                            case .stepper:
                                Stepper {
                                    Text("Value")
                                    Text(stepperValue, format: .number)
                                } onIncrement: {
                                    withAnimation {
                                        stepperValue += stepperStep
                                        if stepperValue >= 10 {
                                            stepperValue = 10
                                        }
                                    }
                                } onDecrement: {
                                    withAnimation {
                                        stepperValue -= stepperStep
                                        if stepperValue < 0 { stepperValue = 0 }
                                    }
                                }
                            case .toggle:
                                Toggle("Toggle", isOn: $toggleValue.animation())
                            case .picker:
                                switch selectedPickerStyleType {
                                case .automatic:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .pickerStyle(.automatic)
                                case .inline:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .pickerStyle(.inline)
                                case .menu:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .pickerStyle(.menu)
                                case .navigationLink:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .pickerStyle(.navigationLink)
                                case .palette:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .pickerStyle(.palette)
                                case .radioGroup:
                                    #if os(iOS)
                                        Text("macOS only")
                                    #elseif os(macOS)
                                        Picker(selection: $selectedFlavor) {
                                            Text("Chocolate").tag(
                                                Flavor.chocolate)
                                            Text("Vanilla").tag(Flavor.vanilla)
                                            Text("Strawberry").tag(
                                                Flavor.strawberry)
                                        } label: {
                                            Text("Flavor")
                                        }
                                        .pickerStyle(.radioGroup)
                                    #endif
                                case .segmented:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .pickerStyle(.segmented)
                                case .wheel:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .pickerStyle(.wheel)
                                }
                            case .datePicker:
                                switch selectedDatePickerStyleType {
                                case .automatic:
                                    DatePicker(
                                        "Time", selection: $datePickerValue
                                    )
                                    .datePickerStyle(.automatic)
                                case .compact:
                                    DatePicker(
                                        "Time", selection: $datePickerValue
                                    )
                                    .datePickerStyle(.compact)
                                case .field:
                                    #if os(iOS)
                                        Text(".field macOS only")
                                    #elseif os(macOS)
                                        DatePicker(
                                            "Time", selection: $datePickerValue
                                        )
                                        .datePickerStyle(.field)
                                    #endif
                                case .graphical:
                                    DatePicker(
                                        "Time", selection: $datePickerValue
                                    )
                                    .datePickerStyle(.graphical)
                                case .stepperField:
                                    #if os(iOS)
                                        Text(".stepperField macOS only")
                                    #elseif os(macOS)
                                        DatePicker(
                                            "Time", selection: $datePickerValue
                                        )
                                        .datePickerStyle(.stepperField)
                                    #endif
                                case .wheel:
                                    DatePicker(
                                        "Time", selection: $datePickerValue
                                    )
                                    .datePickerStyle(.wheel)
                                }
                            case .multiDatePicker:
                                #if os(iOS)
                                    Text("macOS only")
                                #elseif os(macOS)
                                    MultiDatePicker(
                                        "Time", selection: $datePickerValue)
                                #endif
                            case .colorPicker:
                                ColorPicker(
                                    "Color Picker",
                                    selection: $colorPickerValue,
                                    supportsOpacity: supportsOpacity)
                            case .gauge:
                                switch selectedGaugeStyleType {
                                case .automatic:
                                    Gauge(
                                        value: gaugeCurrentValue,
                                        in: gaugeMinValue...gaugeMaxValue
                                    ) {
                                        Text("BPM")
                                    } currentValueLabel: {
                                        Text(gaugeCurrentValue, format: .number)
                                    } minimumValueLabel: {
                                        Text(gaugeMinValue, format: .number)
                                    } maximumValueLabel: {
                                        Text(gaugeMaxValue, format: .number)
                                    }
                                case .circular:
                                    #if os(iOS)
                                        Text("watchOS only")
                                    #elseif os(watchOS)
                                        Gauge(
                                            value: gaugeCurrentValue,
                                            in: gaugeMinValue...gaugeMaxValue
                                        ) {
                                            Text("BPM")
                                        } currentValueLabel: {
                                            Text(
                                                gaugeCurrentValue,
                                                format: .number)
                                        } minimumValueLabel: {
                                            Text(gaugeMinValue, format: .number)
                                        } maximumValueLabel: {
                                            Text(gaugeMaxValue, format: .number)
                                        }
                                        .gaugeStyle(.circular)
                                    #endif

                                case .linear:
                                    #if os(iOS)
                                        Text("watchOS only")
                                    #elseif os(watchOS)
                                        Gauge(
                                            value: gaugeCurrentValue,
                                            in: gaugeMinValue...gaugeMaxValue
                                        ) {
                                            Text("BPM")
                                        } currentValueLabel: {
                                            Text(
                                                gaugeCurrentValue,
                                                format: .number)
                                        } minimumValueLabel: {
                                            Text(gaugeMinValue, format: .number)
                                        } maximumValueLabel: {
                                            Text(gaugeMaxValue, format: .number)
                                        }
                                        .gaugeStyle(.linear)
                                    #endif
                                }
                            case .progressView:
                                switch selectedProgressViewStyleType {
                                case .automatic:
                                    VStack {
                                        ProgressView(
                                            "ProgressView",
                                            value: progressValue,
                                            total: progressTotal)
                                        ProgressView(
                                            timerInterval:
                                                Date()...Date()
                                                .addingTimeInterval(
                                                    5 * 60)
                                        ) {
                                            Text("Workout")
                                        }
                                    }
                                case .circular:
                                    HStack {
                                        Spacer()
                                        VStack {
                                            ProgressView(
                                                "ProgressView",
                                                value: progressValue,
                                                total: progressTotal)
                                            ProgressView(
                                                timerInterval:
                                                    Date()...Date()
                                                    .addingTimeInterval(
                                                        5 * 60)
                                            ) {
                                                Text("Workout")
                                            }
                                        }
                                        Spacer()
                                    }
                                    .progressViewStyle(.circular)
                                case .linear:
                                    VStack {
                                        ProgressView(
                                            "ProgressView",
                                            value: progressValue,
                                            total: progressTotal)
                                        ProgressView(
                                            timerInterval:
                                                Date()...Date()
                                                .addingTimeInterval(
                                                    5 * 60)
                                        ) {
                                            Text("Workout")
                                        }
                                    }
                                    .progressViewStyle(.linear)
                                }
                            case .contentUnavailableView:
                                ContentUnavailableView {
                                    Label("No Mail", systemImage: "tray.fill")
                                } description: {
                                    Text(
                                        "New mails you receive will appear here."
                                    )
                                }
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .frame(height: listHeight)
                    Divider()
                    List {
                        Section {
                            Picker(
                                "Type", selection: $selectedCAITye.animation()
                            ) {
                                ForEach(ControlsAndIndicatorsType.allCases) {
                                    type in
                                    Text(type.name)
                                }
                            }
                        } footer: {
                            if showDescription {
                                Text(selectedCAITye.description)
                            }
                        }

                        Section("Control") {
                            switch selectedCAITye {
                            case .button:
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".controlSize",
                                        selection: $selectedControlSize
                                    ) {
                                        ForEach(
                                            ControlSize.allCases, id: \.self
                                        ) {
                                            size in
                                            Text(size.name)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "The size classes, like regular or small, that you can apply to controls within a view."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                    Toggle(
                                        ".buttonRepeatBehavior",
                                        isOn: $buttonRepeatBehavior)
                                    if showDescription {
                                        Text(
                                            "Sets whether buttons in this view should repeatedly trigger their actions on prolonged interactions."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                VStack {
                                    Picker(
                                        ".buttonStyle",
                                        selection: $selectedButtonStyleType
                                    ) {
                                        ForEach(
                                            ButtonStyleType.allCases, id: \.id
                                        ) {
                                            type in
                                            Text(type.name)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "Sets the style for buttons within this view to a button style with a custom appearance and standard interaction behavior."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            case .editButton:
                                Text("editButton")
                            case .pasteButton:
                                Text("pasteButton")
                            case .renameButton:
                                Text("renameButton")
                            case .link:
                                Text("link")
                            case .shareLink:
                                Text("shareLink")
                            case .sharePreview:
                                Text("sharePreview")
                            case .textFieldLink:
                                Text("textFieldLink")
                            case .helpLink:
                                Text("helpLink")
                            case .slider:
                                Stepper(value: $sliderStep) {
                                    Text("Slider step")
                                    Text(sliderStep, format: .number)
                                }
                            case .stepper:
                                Stepper {
                                    Text("Stepper step")
                                    Text(stepperStep, format: .number)
                                } onIncrement: {
                                    stepperStep += 1
                                    if stepperStep >= 10 { stepperStep = 10 }
                                } onDecrement: {
                                    stepperStep -= 1
                                    if stepperStep < 0 { stepperStep = 0 }
                                }
                            case .toggle:
                                Text("Control")
                            case .picker:
                                VStack(alignment: .leading) {
                                    Picker(
                                        "pickerStyle",
                                        selection: $selectedPickerStyleType
                                    ) {
                                        ForEach(
                                            PickerStyleType.allCases, id: \.self
                                        ) {
                                            type in
                                            Text(type.name)
                                        }
                                    }
                                    Text(
                                        "Sets the style for pickers within this view."
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            case .datePicker:
                                Picker(
                                    "DatePicker Style",
                                    selection:
                                        $selectedDatePickerStyleType.animation()
                                ) {
                                    ForEach(
                                        DatePickerStyleType.allCases, id: \.self
                                    ) {
                                        type in
                                        Text(type.name)
                                    }
                                }
                            case .multiDatePicker:
                                Text("Control")
                            case .colorPicker:
                                Toggle(
                                    "supportsOpacity", isOn: $supportsOpacity)
                            case .gauge:
                                Picker(
                                    "Gauge Style",
                                    selection:
                                        $selectedGaugeStyleType.animation()
                                ) {
                                    ForEach(GaugeStyleType.allCases, id: \.id) {
                                        type in
                                        Text(type.name)
                                    }
                                }
                            case .progressView:
                                Picker(
                                    "ProgressView Style",
                                    selection:
                                        $selectedProgressViewStyleType.animation()
                                ) {
                                    ForEach(
                                        ProgressViewStyleType.allCases, id: \.id
                                    ) {
                                        type in
                                        Text(type.name)
                                    }
                                }
                            case .contentUnavailableView:
                                Text("Control")
                            }
                        }

                        Section("Value") {
                            switch selectedCAITye {
                            case .button:
                                LabeledContent(
                                    "Count", value: clickCount, format: .number)
                            case .editButton:
                                LabeledContent("Result", value: pastedText)
                            case .pasteButton:
                                LabeledContent("Result", value: pastedText)
                            case .renameButton:
                                LabeledContent(
                                    "Result", value: isFocused ? "Renaming" : ""
                                )
                            case .link:
                                LabeledContent("Opened URL", value: openedURL)
                            case .shareLink:
                                LabeledContent("Result", value: pastedText)
                            case .sharePreview:
                                LabeledContent("Result", value: pastedText)
                            case .textFieldLink:
                                LabeledContent("Result", value: pastedText)
                            case .helpLink:
                                LabeledContent("Result", value: pastedText)
                            case .slider:
                                LabeledContent(
                                    "Sliding",
                                    value: isSliding ? "True" : "False")
                                LabeledContent(
                                    "Value", value: sliderValue, format: .number
                                )
                                LabeledContent(
                                    "Range LowerBound",
                                    value: sliderRange.lowerBound,
                                    format: .number)
                                LabeledContent(
                                    "Range UpperBound",
                                    value: sliderRange.upperBound,
                                    format: .number)
                            case .stepper:
                                LabeledContent(
                                    "Stepper Value", value: stepperValue,
                                    format: .number)
                            case .toggle:
                                LabeledContent(
                                    "Value",
                                    value: toggleValue ? "True" : "False")
                            case .picker:
                                LabeledContent(
                                    "Picker Value",
                                    value: selectedFlavor.rawValue)
                            case .datePicker:
                                LabeledContent(
                                    "DatePicker Value", value: datePickerValue,
                                    format: .dateTime)
                            case .multiDatePicker:
                                LabeledContent("Result", value: pastedText)
                            case .colorPicker:
                                LabeledContent("ColorPicker Value") {
                                    Circle()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(colorPickerValue)
                                }
                            case .gauge:
                                LabeledContent("Result", value: pastedText)
                            case .progressView:
                                LabeledContent("Result", value: pastedText)
                            case .contentUnavailableView:
                                LabeledContent("Result", value: pastedText)
                            }
                        }
                    }
                }
                .navigationTitle("Controls and indicators")
                #if os(iOS)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarVisibility(
                        hideTabBar ? .hidden : .automatic, for: .tabBar)
                #endif
                .toolbar {
                    Menu {
                        Toggle(isOn: $showDescription.animation()) {
                            Label("Show Description", systemImage: "eye")
                        }
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                    }
                }
                .onAppear {
                    withAnimation {
                        hideTabBar = true
                    }
                }
            #endif
        }
    }
}

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

#Preview {
    ControlsAndIndicatorsView()
}
