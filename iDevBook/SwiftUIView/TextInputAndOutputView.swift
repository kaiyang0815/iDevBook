//
//  TextInputAndOutputView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/31.
//
//

import SwiftUI

enum TextInputAndOutputType: String, CaseIterable, Identifiable {
    case text
    case label
    case textField
    case secureField
    case textEditor

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .text:
            "Text"
        case .label:
            "Label"
        case .textField:
            "TextField"
        case .secureField:
            "SecureField"
        case .textEditor:
            "TextEditor"
        }
    }

    var description: String {
        switch self {
        case .text:
            "A view that displays one or more lines of read-only text."
        case .label:
            "A standard label for user interface items, consisting of an icon with a title."
        case .textField:
            "A control that displays an editable text interface."
        case .secureField:
            "A control into which people securely enter private text."
        case .textEditor:
            "A view that can display and edit long-form text."
        }
    }
}

enum LabelStyleType: String, CaseIterable, Identifiable {
    case automatic
    case iconOnly
    case titleAndIcon
    case titleOnly

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "automatic"
        case .iconOnly:
            "iconOnly"
        case .titleAndIcon:
            "titleAndIcon"
        case .titleOnly:
            "titleOnly"
        }
    }
}

enum TextFieldStyleType: String, CaseIterable, Identifiable {
    case automatic
    case plain
    case roundedBorder
    case squareBorder

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .automatic:
            "automatic"
        case .plain:
            "plain"
        case .roundedBorder:
            "roundedBorder"
        case .squareBorder:
            "squareBorder"
        }
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool, transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct TextInputAndOutputView: View {
    @State private var showDescription: Bool = false
    @State private var selectedTextInputAndOutputType: TextInputAndOutputType =
        .textEditor

    @State private var textValue: String =
        "You can’t connect the dots looking forward; you can only connect them looking backwards. So you have to trust that the dots will somehow connect in your future."
    @State private var fontTextStyle: Font = .body
    @State private var fontWeight: Font.Weight = .regular
    @State private var fontWidth: Font.Width = .standard
    @State private var fontForegroundStyle: Color = .primary
    @State private var fontDecorationColor: Color = .secondary
    @State private var fontDesign: Font.Design = .default
    @State private var fontItalic: Bool = false
    @State private var fontStrikethrough: Bool = false
    @State private var fontUnderline: Bool = false
    @State private var fontMonospaced: Bool = false
    @State private var fontMonospacedDigit: Bool = false
    @State private var fontKerning: CGFloat = 0
    @State private var fontTracking: CGFloat = 0
    @State private var fontBaselineOffset: CGFloat = 0
    @State private var fontTruncationMode: Text.TruncationMode = .tail
    @State private var fontMultilineTextAlignment: TextAlignment = .leading
    @State private var fontLineSpacing: CGFloat = 0
    @State private var allowTextSelection: Bool = false

    @State private var fontLineLimit: Int = 3

    @State private var labelValue: String = "Lightning"
    @State private var selectedLabelStyleType: LabelStyleType = .automatic

    @State private var textFieldValue: String = "Some text"
    @State private var selectedTextFieldStyleType: TextFieldStyleType =
        .automatic
    @State private var textFieldScrollable: Bool = false
    @State private var allowAutoCorrection: Bool = false
    #if os(iOS)
        @State private var selectedKeyboardType: UIKeyboardType = .default
    #endif
    @State private var selectedScrollDismissesKeyboardMode:
        ScrollDismissesKeyboardMode = .automatic

    @State private var secureFieldValue: String = "123456789"
    @State private var textEditorValue: String =
        "You can’t connect the dots looking forward; you can only connect them looking backwards. So you have to trust that the dots will somehow connect in your future."

    @FocusState private var textFieldIsFocused: Bool
    @State private var hideTabBar: Bool = false
    @State private var showInspector: Bool = false

    var listHeight: Double {
        switch selectedTextInputAndOutputType {
        case .text:
            140
        case .label:
            100
        case .textField:
            100
        case .secureField:
            100
        case .textEditor:
            200
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                switch selectedTextInputAndOutputType {
                case .text:
                    Text(textValue)
                        .font(fontTextStyle)
                        .fontWeight(fontWeight)
                        .fontDesign(fontDesign)
                        .fontWidth(fontWidth)
                        .foregroundStyle(fontForegroundStyle)
                        .italic(fontItalic)
                        .strikethrough(
                            fontStrikethrough,
                            color: fontDecorationColor
                        )
                        .underline(fontUnderline)
                        .monospaced(fontMonospaced)
                        .kerning(fontKerning)
                        .tracking(fontTracking)
                        .baselineOffset(fontBaselineOffset)
                        .lineLimit(fontLineLimit)
                        .truncationMode(fontTruncationMode)
                        .multilineTextAlignment(
                            fontMultilineTextAlignment
                        )
                        .lineSpacing(fontLineSpacing)
                        .if(allowTextSelection) { view in
                            view.textSelection(.enabled)
                        }
                case .label:
                    Group {
                        switch selectedLabelStyleType {
                        case .automatic:
                            Label(
                                labelValue,
                                systemImage: "bolt.fill"
                            )
                            .labelStyle(.automatic)
                        case .iconOnly:
                            Label(
                                labelValue,
                                systemImage: "bolt.fill"
                            )
                            .labelStyle(.iconOnly)
                        case .titleAndIcon:
                            Label(
                                labelValue,
                                systemImage: "bolt.fill"
                            )
                            .labelStyle(.titleAndIcon)
                        case .titleOnly:
                            Label(
                                labelValue,
                                systemImage: "bolt.fill"
                            )
                            .labelStyle(.titleOnly)
                        }
                    }
                    .font(fontTextStyle)
                    .fontWeight(fontWeight)
                    .fontDesign(fontDesign)
                    .fontWidth(fontWidth)
                    .foregroundStyle(fontForegroundStyle)
                    .italic(fontItalic)
                    .strikethrough(
                        fontStrikethrough,
                        color: fontDecorationColor
                    )
                    .monospaced(fontMonospaced)
                    .kerning(fontKerning)
                case .textField:
                    Group {
                        switch selectedTextFieldStyleType {
                        case .automatic:
                            TextField(
                                "Enter", text: $textFieldValue,
                                axis: textFieldScrollable
                                    ? .vertical : .horizontal
                            )
                            .textFieldStyle(.automatic)
                        case .plain:
                            TextField(
                                "Enter", text: $textFieldValue,
                                axis: textFieldScrollable
                                    ? .vertical : .horizontal
                            )
                            .textFieldStyle(.plain)
                        case .roundedBorder:
                            TextField(
                                "Enter", text: $textFieldValue,
                                axis: textFieldScrollable
                                    ? .vertical : .horizontal
                            )
                            .textFieldStyle(.roundedBorder)
                        case .squareBorder:
                            #if os(iOS)
                                Text("macOS only")
                            #elseif os(macOS)
                                TextField(
                                    "Enter",
                                    text: $textFieldValue,
                                    axis: textFieldScrollable
                                        ? .vertical
                                        : .horizontal
                                )
                                .textFieldStyle(.squareBorder)
                            #endif
                        }
                    }
                    .focused($textFieldIsFocused)
                    .font(fontTextStyle)
                    .fontWeight(fontWeight)
                    .fontWidth(fontWidth)
                    .foregroundStyle(fontForegroundStyle)
                    .fontDesign(fontDesign)
                    .autocorrectionDisabled(allowAutoCorrection)
                    #if os(iOS)
                        .keyboardType(selectedKeyboardType)
                    #endif
                    .scrollDismissesKeyboard(
                        selectedScrollDismissesKeyboardMode
                    )
                case .secureField:
                    SecureField(
                        "Password", text: $secureFieldValue)
                case .textEditor:
                    TextEditor(text: $textEditorValue)
                        .frame(height: 120)
                        .font(fontTextStyle)
                        .fontWeight(fontWeight)
                        .fontWidth(fontWidth)
                        .fontDesign(fontDesign)
                        .italic(fontItalic)
                        .lineSpacing(fontLineSpacing)
                        .foregroundStyle(fontForegroundStyle)
                }
            }
            .inspector(
                isPresented: $showInspector,
                content: {
                    List {
                        Section {
                            VStack(alignment: .leading) {
                                Picker(
                                    "Type",
                                    selection:
                                        $selectedTextInputAndOutputType
                                        .animation()
                                ) {
                                    ForEach(
                                        TextInputAndOutputType.allCases,
                                        id: \.id
                                    ) {
                                        type in
                                        Text(type.name)
                                    }
                                }
                            }
                        } footer: {
                            if showDescription {
                                Text(selectedTextInputAndOutputType.description)
                            }
                        }

                        // MARK: - Picker
                        Section("Control") {
                            if selectedTextInputAndOutputType != .secureField {
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".font",
                                        selection: $fontTextStyle.animation()
                                    ) {
                                        ForEach(Font.allCases, id: \.name) {
                                            font in
                                            Text(font.name)
                                                .tag(font)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "Sets the default font for text in the view."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".fontWeight",
                                        selection: $fontWeight.animation()
                                    ) {
                                        ForEach(
                                            Font.Weight.allCases, id: \.name
                                        ) {
                                            weight in
                                            Text(weight.name)
                                                .tag(weight)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "Sets the font weight of the text."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".fontWidth",
                                        selection: $fontWidth.animation()
                                    ) {
                                        ForEach(Font.Width.allCases, id: \.name)
                                        {
                                            width in
                                            Text(width.name)
                                                .tag(width)
                                        }
                                    }
                                    if showDescription {
                                        Text("Sets the font width of the text.")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".fontDesign",
                                        selection: $fontDesign.animation()
                                    ) {
                                        ForEach(
                                            Font.Design.allCases, id: \.self
                                        ) {
                                            design in
                                            Text(design.name)
                                                .tag(design)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "Sets the font design of the text."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            if selectedTextInputAndOutputType == .text {
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".truncationMode",
                                        selection:
                                            $fontTruncationMode.animation()
                                    ) {
                                        ForEach(
                                            Text.TruncationMode.allCases,
                                            id: \.self
                                        ) {
                                            mode in
                                            Text(mode.name)
                                                .tag(mode)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "The type of truncation to apply to a line of text when it’s too long to fit in the available space."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".multilineTextAlignment",
                                        selection:
                                            $fontMultilineTextAlignment
                                            .animation()
                                    ) {
                                        ForEach(
                                            TextAlignment.allCases, id: \.self
                                        ) {
                                            mode in
                                            Text(mode.name)
                                                .tag(mode)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "An environment value that indicates how a text view aligns its lines when the content wraps or contains newlines."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            if selectedTextInputAndOutputType == .label {
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".labelStyle",
                                        selection:
                                            $selectedLabelStyleType.animation()
                                    ) {
                                        ForEach(
                                            LabelStyleType.allCases, id: \.id
                                        ) {
                                            type in
                                            Text(type.name)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "A label style that only displays the title of the label."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            if selectedTextInputAndOutputType == .textField {
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".textFieldStyle",
                                        selection:
                                            $selectedTextFieldStyleType
                                            .animation()
                                    ) {
                                        ForEach(
                                            TextFieldStyleType.allCases,
                                            id: \.id
                                        ) {
                                            type in
                                            Text(type.name)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "A label style that only displays the title of the label."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    #if os(iOS)
                                        Picker(
                                            ".keyboardType",
                                            selection:
                                                $selectedKeyboardType.animation()
                                        ) {
                                            ForEach(
                                                UIKeyboardType.allCases,
                                                id: \.self
                                            ) {
                                                type in
                                                Text(type.name)
                                            }
                                        }
                                        if showDescription {
                                            Text(
                                                "A label style that only displays the title of the label."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    #endif
                                }
                                VStack(alignment: .leading) {
                                    Picker(
                                        ".scrollDismissesKeyboard",
                                        selection:
                                            $selectedScrollDismissesKeyboardMode
                                            .animation()
                                    ) {
                                        ForEach(
                                            ScrollDismissesKeyboardMode
                                                .allCases,
                                            id: \.self
                                        ) {
                                            mode in
                                            Text(mode.name)
                                        }
                                    }
                                    if showDescription {
                                        Text(
                                            "Configures the behavior in which scrollable content interacts with the software keyboard."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                //                        VStack(alignment: .leading) {
                                //                            Picker(
                                //                                ".textInputAutocapitalization",
                                //                                selection: $selectedTextInputAutocapitalization
                                //                            ) {
                                //                                ForEach(
                                //                                    TextInputAutocapitalization.allCases,
                                //                                    id: \.self
                                //                                ) { type in
                                //
                                //                                }
                                //                            }
                                //
                                //                            if showDescription {
                                //                                Text(
                                //                                    "Sets how often the shift key in the keyboard is automatically enabled."
                                //                                )
                                //                                .font(.caption)
                                //                                .foregroundStyle(.secondary)
                                //                            }
                                //                        }
                            }
                        }

                        // MARK: - ColorPicker
                        Section {
                            if selectedTextInputAndOutputType != .secureField {
                                VStack(alignment: .leading) {
                                    ColorPicker(
                                        "foregroundStyle",
                                        selection:
                                            $fontForegroundStyle.animation())
                                    if showDescription {
                                        Text(
                                            "Sets the style of the text displayed by this view."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    ColorPicker(
                                        "fontDecorationColor",
                                        selection:
                                            $fontDecorationColor.animation())
                                    if showDescription {
                                        Text(
                                            "Sets the color of the text decoration."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }

                        // MARK: - Toggle
                        Section {
                            if selectedTextInputAndOutputType != .secureField {
                                VStack(alignment: .leading) {
                                    Toggle(
                                        ".italic", isOn: $fontItalic.animation()
                                    )
                                    if showDescription {
                                        Text(
                                            "Applies italics to the text."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                if selectedTextInputAndOutputType != .textEditor
                                {
                                    VStack(alignment: .leading) {
                                        Toggle(
                                            ".strikethrough",
                                            isOn: $fontStrikethrough.animation()
                                        )
                                        if showDescription {
                                            Text(
                                                "Applies a strikethrough to the text."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Toggle(
                                            ".underline",
                                            isOn: $fontUnderline.animation())
                                        if showDescription {
                                            Text(
                                                "Applies an underline to the text."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Toggle(
                                            ".monospaced",
                                            isOn: $fontMonospaced.animation()
                                        )
                                        if showDescription {
                                            Text(
                                                "Modifies the font of the text to use the fixed-width variant of the current font, if possible."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Toggle(
                                            ".textSelection",
                                            isOn:
                                                $allowTextSelection.animation())
                                        if showDescription {
                                            Text(
                                                "Controls whether people can select text within this view."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            if selectedTextInputAndOutputType == .textField {
                                VStack(alignment: .leading) {
                                    Toggle(
                                        "Scrollable",
                                        isOn: $textFieldScrollable.animation())
                                    if showDescription {
                                        Text(
                                            "Controls whether people can scroll the TextField."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Toggle(
                                        ".autocorrectionDisabled",
                                        isOn: $allowAutoCorrection.animation())
                                    if showDescription {
                                        Text(
                                            "Sets whether to disable autocorrection for this view."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }

                        // MARK: - Steeper
                        Section {
                            if selectedTextInputAndOutputType != .secureField {
                                if selectedTextInputAndOutputType != .textEditor
                                {
                                    VStack(alignment: .leading) {
                                        Stepper(value: $fontKerning.animation())
                                        {
                                            Text(".kerning")
                                            Text(fontKerning, format: .number)
                                        }
                                        if showDescription {
                                            Text(
                                                "Sets the spacing, or kerning, between characters."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Stepper(
                                            value: $fontTracking.animation()
                                        ) {
                                            Text(".tracking")
                                            Text(fontTracking, format: .number)
                                        }
                                        if showDescription {
                                            Text(
                                                "Sets the tracking for the text."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Stepper(
                                            value:
                                                $fontBaselineOffset.animation()
                                        ) {
                                            Text(".baselineOffset")
                                            Text(
                                                fontBaselineOffset,
                                                format: .number)
                                        }
                                        if showDescription {
                                            Text(
                                                "Sets the vertical offset for the text relative to its baseline."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Stepper(
                                            value: $fontLineLimit.animation()
                                        ) {
                                            Text(".lineLimit")
                                            Text(fontLineLimit, format: .number)
                                        }
                                        if showDescription {
                                            Text(
                                                "The maximum number of lines that text can occupy in a view."
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Stepper(value: $fontLineSpacing.animation())
                                    {
                                        Text(".lineSpacing")
                                        Text(fontLineSpacing, format: .number)
                                    }
                                    if showDescription {
                                        Text(
                                            "Sets the amount of space between lines of text in this view."
                                        )
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }

                        Section("Value") {

                        }
                    }
                }
            )
            .navigationTitle("Text input and output")
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
        }
    }
}

extension Font {
    static var allCases: [Font] {
        return [
            .largeTitle,
            .title,
            .title2,
            .title3,
            .headline,
            .subheadline,
            .body,
            .callout,
            .caption,
            .caption2,
            .footnote,
        ]
    }

    var name: String {
        switch self {
        case .largeTitle:
            "largeTitle"
        case .title:
            "title"
        case .title2:
            "title2"
        case .title3:
            "title3"
        case .headline:
            "headline"
        case .subheadline:
            "subheadline"
        case .body:
            "body"
        case .callout:
            "callout"
        case .caption:
            "caption"
        case .caption2:
            "caption2"
        case .footnote:
            "footnote"
        default:
            "unknown"
        }
    }
}

extension Font.Weight {
    static var allCases: [Font.Weight] {
        return [
            .ultraLight,
            .thin,
            .light,
            .regular,
            .medium,
            .semibold,
            .bold,
            .heavy,
            .black,
        ]
    }

    var name: String {
        switch self {
        case .ultraLight:
            "ultraLight"
        case .thin:
            "thin"
        case .light:
            "light"
        case .regular:
            "regular"
        case .medium:
            "medium"
        case .semibold:
            "semibold"
        case .bold:
            "bold"
        case .heavy:
            "heavy"
        case .black:
            "black"
        default:
            "unknown"
        }
    }
}

extension Font.Width {
    static var allCases: [Font.Width] {
        return [.compressed, .condensed, .expanded, .standard]
    }

    var name: String {
        switch self {
        case .compressed:
            "compressed"
        case .condensed:
            "condensed"
        case .expanded:
            "expanded"
        case .standard:
            "standard"
        default:
            "unknown"
        }
    }
}

extension Font.Design {
    static var allCases: [Font.Design] {
        return [.default, .serif, .rounded, .monospaced]
    }

    var name: String {
        switch self {
        case .default:
            "default"
        case .serif:
            "serif"
        case .rounded:
            "rounded"
        case .monospaced:
            "monospaced"
        @unknown default:
            "unknown"
        }
    }
}

extension Text.TruncationMode {
    static var allCases: [Text.TruncationMode] {
        return [.head, .middle, .tail]
    }

    var name: String {
        switch self {
        case .head:
            "head"
        case .tail:
            "tail"
        case .middle:
            "middle"
        @unknown default:
            "unknown"
        }
    }
}

extension TextAlignment {
    static var allCases: [TextAlignment] {
        return [.leading, .center, .trailing]
    }

    var name: String {
        switch self {
        case .leading:
            "leading"
        case .center:
            "center"
        case .trailing:
            "trailing"
        }
    }
}

#if os(iOS)
    extension UIKeyboardType {
        static var allCases: [UIKeyboardType] {
            return [
                .default, .asciiCapable, .numbersAndPunctuation, .URL,
                .numberPad,
                .phonePad, .namePhonePad, .emailAddress, .decimalPad, .twitter,
                .webSearch, .asciiCapableNumberPad,
            ]
        }

        var name: String {
            switch self {
            case .default:
                "default"
            case .asciiCapable:
                "asciiCapable"
            case .numbersAndPunctuation:
                "numbersAndPunctuation"
            case .URL:
                "URL"
            case .numberPad:
                "numberPad"
            case .phonePad:
                "phonePad"
            case .namePhonePad:
                "namePhonePad"
            case .emailAddress:
                "emailAddress"
            case .decimalPad:
                "decimalPad"
            case .twitter:
                "twitter"
            case .webSearch:
                "webSearch"
            case .asciiCapableNumberPad:
                "asciiCapableNumberPad"
            @unknown default:
                "unknown"
            }
        }
    }
#endif

extension ScrollDismissesKeyboardMode {
    static var allCases: [ScrollDismissesKeyboardMode] {
        return [.automatic, .immediately, .interactively, .never]
    }

    var name: String {
        switch self {
        case .automatic:
            "automatic"
        case .immediately:
            "immediately"
        case .interactively:
            "interactively"
        case .never:
            "never"
        default:
            "unknown"
        }
    }
}

#Preview {
    TextInputAndOutputView()
}
