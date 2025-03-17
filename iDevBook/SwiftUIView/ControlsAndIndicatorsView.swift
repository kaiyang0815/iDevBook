//
//  ControlsAndIndicatorsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/31.
//
//

import SwiftUI

struct ControlsAndIndicatorsView: View {
    @State private var selectedCAITye: ControlsAndIndicatorsType =
        .link
    @State private var selectedFlavor: Flavor = .chocolate
    @State private var selectedPickerStyleType: PickerStyleType = .automatic
    @State private var selectedDatePickerStyleType: DatePickerStyleType =
        .automatic
    @State private var selectedGaugeStyleType: GaugeStyleType = .automatic
    @State private var selectedProgressViewStyleType: ProgressViewStyleType =
        .automatic
    @State private var selectedButtonStyleType: CustomButtonStyleType =
        .automatic
    @State private var selectedControlSize: ControlSize = .regular
    @State private var selectedButtonBorderShape: EButtonBorderShape =
        .automatic

    @State private var buttonLabelType: Bool = false
    @State private var clickCount: Int = 0
    @State private var buttonRepeatBehavior: Bool = false
    @State private var pastedText: String = ""
    @State private var name = "Example Name"
    @State private var openedURL = ""
    @State private var destinationURL = "https://developer.apple.com"
    @State private var sliderValue = 50.0
    @State private var isSliding = false
    @State private var sliderRange = 0.0...100.0
    @State private var sliderStep = 5.0
    @State private var stepperValue: Double = 0
    @State private var stepperStep: Double = 1
    @State private var toggleValue: Bool = false
    @State private var datePickerValue = Date.now
    @State private var selectedMode: DatePickerMode = .dateAndTime
    @State private var setHorizontalRadioGroupLayout: Bool = false

    @State private var dates: Set<DateComponents> = []
    @State private var colorPickerValue = Color.red
    @State private var supportsOpacity = true
    @State private var gaugeCurrentValue = 60.0
    @State private var gaugeMinValue = 0.0
    @State private var gaugeMaxValue = 100.0
    @State private var progressValue = 0.5
    @State private var progressTotal = 1.0

    @State private var showDescription: Bool = true
    @State private var hideTabBar: Bool = false
    @State private var showInspector: Bool = true
    @State private var size: CGSize = .zero
    #if os(iOS)
        @State private var editMode: EditMode = .inactive
    #endif
    @State private var textLabel: Bool = true

    @Environment(\.calendar) var calendar
    @Environment(\.timeZone) var timeZone

    @FocusState private var isFocused: Bool

    var bounds: Range<Date> {
        let start = calendar.date(
            from: DateComponents(
                timeZone: timeZone, year: 2022, month: 6, day: 6))!
        let end = calendar.date(
            from: DateComponents(
                timeZone: timeZone, year: 2022, month: 6, day: 16))!
        return start..<end
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        CardContainerView {
                            HStack {
                                switch selectedCAITye {
                                case .button:
                                    Button {
                                        withAnimation {
                                            clickCount += 1
                                        }
                                    } label: {
                                        if textLabel {
                                            Text("Click")
                                        } else {
                                            Label(
                                                "Good",
                                                systemImage: "hand.thumbsup")
                                        }
                                    }
                                    .customButtonStyle(selectedButtonStyleType)
                                    .buttonBorderShape(
                                        selectedButtonBorderShape.style
                                    )
                                    .buttonRepeatBehavior(
                                        buttonRepeatBehavior
                                            ? .enabled : .disabled
                                    )
                                    .sensoryFeedback(
                                        .success, trigger: clickCount
                                    )
                                    .controlSize(selectedControlSize)
                                case .editButton:
                                    #if os(iOS)
                                        EditButton()
                                            .customButtonStyle(
                                                selectedButtonStyleType
                                            )
                                            .buttonBorderShape(
                                                selectedButtonBorderShape.style
                                            )
                                            .buttonRepeatBehavior(
                                                buttonRepeatBehavior
                                                    ? .enabled : .disabled
                                            )
                                            .sensoryFeedback(
                                                .success, trigger: clickCount
                                            )
                                            .controlSize(selectedControlSize)
                                    #else
                                        Text("iOS only")
                                    #endif
                                case .pasteButton:
                                    PasteButton(payloadType: String.self) {
                                        strings in
                                        withAnimation {
                                            pastedText = strings[0]
                                        }
                                    }
                                    .customButtonStyle(selectedButtonStyleType)
                                    .buttonBorderShape(
                                        selectedButtonBorderShape.style
                                    )
                                    .buttonRepeatBehavior(
                                        buttonRepeatBehavior
                                            ? .enabled : .disabled
                                    )
                                    .sensoryFeedback(
                                        .success, trigger: clickCount
                                    )
                                    .controlSize(selectedControlSize)
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
                                        .customButtonStyle(
                                            selectedButtonStyleType
                                        )
                                        .buttonBorderShape(
                                            selectedButtonBorderShape.style
                                        )
                                        .buttonRepeatBehavior(
                                            buttonRepeatBehavior
                                                ? .enabled : .disabled
                                        )
                                        .sensoryFeedback(
                                            .success, trigger: clickCount
                                        )
                                        .controlSize(selectedControlSize)
                                case .link:
                                    Link(
                                        destination: URL(
                                            string: destinationURL)!
                                    ) {
                                        if textLabel {
                                            Text("Open URL")
                                        } else {
                                            Label(
                                                "Open in browser",
                                                systemImage: "safari")
                                        }
                                    }
                                    .environment(
                                        \.openURL,
                                        OpenURLAction { url in
                                            withAnimation {
                                                self.openedURL =
                                                    url.absoluteString
                                                return .handled
                                            }
                                        }
                                    )
                                    .controlSize(.large)
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
                                            sliderRange.lowerBound,
                                            format: .number)
                                    } maximumValueLabel: {
                                        Text(
                                            sliderRange.upperBound,
                                            format: .number)
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
                                            if stepperValue < 0 {
                                                stepperValue = 0
                                            }
                                        }
                                    }
                                case .toggle:
                                    Toggle(isOn: $toggleValue.animation()) {
                                        if textLabel {
                                            Text("Toggle")
                                        } else {
                                            Label(
                                                "Toggle",
                                                systemImage: "switch.2")
                                        }
                                    }
                                case .picker:
                                    Picker(selection: $selectedFlavor) {
                                        Text("Chocolate").tag(
                                            Flavor.chocolate)
                                        Text("Vanilla").tag(Flavor.vanilla)
                                        Text("Strawberry").tag(
                                            Flavor.strawberry)
                                    } label: {
                                        Text("Flavor")
                                    }
                                    .switchPickerStyle(selectedPickerStyleType)
                                    //                                    .paletteSelectionEffect(.custom)
                                    #if os(macOS)
                                        .if(setHorizontalRadioGroupLayout) {
                                            view in
                                            .horizontalRadioGroupLayout()
                                        }
                                    #endif
                                case .datePicker:
                                    DatePicker(
                                        "DatePicker",
                                        selection: $datePickerValue,
                                        displayedComponents: selectedMode
                                            .components
                                    )
                                    .switchDatePickerStyle(
                                        selectedDatePickerStyleType)
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
                                            Text(
                                                gaugeCurrentValue,
                                                format: .number)
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
                                                in:
                                                    gaugeMinValue...gaugeMaxValue
                                            ) {
                                                Text("BPM")
                                            } currentValueLabel: {
                                                Text(
                                                    gaugeCurrentValue,
                                                    format: .number)
                                            } minimumValueLabel: {
                                                Text(
                                                    gaugeMinValue,
                                                    format: .number)
                                            } maximumValueLabel: {
                                                Text(
                                                    gaugeMaxValue,
                                                    format: .number)
                                            }
                                            .gaugeStyle(.circular)
                                        #endif

                                    case .linear:
                                        #if os(iOS)
                                            Text("watchOS only")
                                        #elseif os(watchOS)
                                            Gauge(
                                                value: gaugeCurrentValue,
                                                in:
                                                    gaugeMinValue...gaugeMaxValue
                                            ) {
                                                Text("BPM")
                                            } currentValueLabel: {
                                                Text(
                                                    gaugeCurrentValue,
                                                    format: .number)
                                            } minimumValueLabel: {
                                                Text(
                                                    gaugeMinValue,
                                                    format: .number)
                                            } maximumValueLabel: {
                                                Text(
                                                    gaugeMaxValue,
                                                    format: .number)
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
                                        Label(
                                            "No Mail", systemImage: "tray.fill")
                                    } description: {
                                        Text(
                                            "New mails you receive will appear here."
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .clearSectionStyle()
                }
                .task {
                    size = proxy.size
                }
                .environment(\.editMode, self.$editMode)
                .onTapGesture(count: 2) {
                    withAnimation {
                        showInspector.toggle()
                    }
                }
                .onTapGesture(count: 2) {
                    withAnimation {
                        showInspector.toggle()
                    }
                }
            }
            .navigationTitle("Controls and indicators")
            .formStyle(.grouped)
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .toolbar {
                Menu {
                    Toggle(isOn: $showInspector.animation()) {
                        Label("Show Inspector", systemImage: "info.circle")
                    }
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
                    showInspector = true
                }
            }
            #if os(iOS)
                .onWillDisappear {
                    withAnimation {
                        showInspector = false
                    }
                }
            #endif
            .inspector(isPresented: $showInspector) {
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
                        if selectedCAITye == .toggle
                            || selectedCAITye == .button
                            || selectedCAITye == .link
                        {
                            Toggle(isOn: $textLabel) {
                                Text("Text or Label")
                            }
                        }
                        switch selectedCAITye {
                        case .button, .editButton, .pasteButton, .renameButton:
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "Sets the style for buttons within this view to a button style with a custom appearance and standard interaction behavior."
                            ) {
                                Picker(
                                    "Button Style",
                                    selection: $selectedButtonStyleType
                                ) {
                                    ForEach(
                                        CustomButtonStyleType.allCases, id: \.id
                                    ) {
                                        type in
                                        Text(type.name)
                                    }
                                }
                            }
                            if selectedButtonStyleType == .bordered
                                || selectedButtonStyleType == .borderedProminent
                            {
                                WithDescriptionView(
                                    showDescription: $showDescription,
                                    description:
                                        "A shape used to draw a button’s border."
                                ) {
                                    PickerContainer(
                                        "Border Shape",
                                        selection: $selectedButtonBorderShape
                                    ) { shape in
                                        Text(shape.name)
                                    }
                                }
                            }
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "Sets whether buttons in this view should repeatedly trigger their actions on prolonged interactions."
                            ) {
                                Toggle(
                                    "Button Repeat Behavior",
                                    isOn: $buttonRepeatBehavior)
                            }
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "The size classes, like regular or small, that you can apply to controls within a view."
                            ) {
                                PickerContainer(
                                    "Control Size",
                                    selection: $selectedControlSize
                                ) { size in
                                    Text(size.name)
                                }
                            }
                        case .link:
                            ClearableTextField(
                                "Destination URL", text: $destinationURL)
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
                            CustomStepperWithDescription(
                                value: $stepperStep,
                                showDescription: $showDescription,
                                label: "Stepper step", range: 0...10, step: 1,
                                fractionLength: 0)
                        case .toggle:
                            Text("Control")
                        case .picker:
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "Sets the style for pickers within this view."
                            ) {
                                PickerContainer(
                                    ".pickerStyle",
                                    selection: $selectedPickerStyleType
                                ) { type in
                                    Text(type.name)
                                        #if os(iOS)
                                            .selectionDisabled(
                                                type == .radioGroup)
                                        #endif
                                }
                            }
                        case .datePicker:
                            PickerContainer(
                                ".datePickerStyle",
                                selection: $selectedDatePickerStyleType
                            ) { type in
                                Text(type.name)
                                    #if os(iOS)
                                        .selectionDisabled(
                                            type == .field
                                                || type == .stepperField)
                                    #endif
                            }
                            PickerContainer(
                                "displayedComponents", selection: $selectedMode
                            ) { mode in
                                Text(mode.rawValue)
                                    .tag(mode)
                            }
                        case .colorPicker:
                            Toggle(
                                "supportsOpacity", isOn: $supportsOpacity)
                        case .gauge:
                            PickerContainer(
                                ".gaugeStyle",
                                selection: $selectedGaugeStyleType
                            ) { type in
                                Text(type.name)
                            }
                        case .progressView:
                            PickerContainer(
                                ".progressViewStyle",
                                selection: $selectedProgressViewStyleType
                            ) { type in
                                Text(type.name)
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
                            #if os(iOS)
                                LabeledContent {
                                    Text(
                                        editMode.isEditing
                                            ? "isEditing" : "None")
                                } label: {
                                    Text("editMode")
                                }
                            #endif

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
        }
    }
}

#Preview {
    ControlsAndIndicatorsView()
}
