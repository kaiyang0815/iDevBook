//
//  ImagesView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/30.
//
//

import SwiftUI

enum SourceType: String, CaseIterable, Identifiable {
    case local
    case asyncImage
    case bitmap
    case symbol

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .local:
            "Local"
        case .asyncImage:
            "Async Image"
        case .bitmap:
            "BitMap"
        case .symbol:
            "Symbol"
        }
    }
}

enum SymbolEffectType: String, CaseIterable, Identifiable {
    case appear
    case bounce
    case disappear
    case pulse
    case scale
    case variableColor
    case breathe
    case rotate
    case wiggle

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .appear:
            "Appear"
        case .bounce:
            "Bounce"
        case .disappear:
            "Disappear"
        case .pulse:
            "Pulse"
        case .scale:
            "Scale"
        case .variableColor:
            "VariableColor"
        case .breathe:
            "Breathe"
        case .rotate:
            "Rotate"
        case .wiggle:
            "Wiggle"
        }
    }

    //    var description: String {
    //
    //    }
}

struct ImagesView: View {
    @State private var selectedSource: SourceType = .local
    @State private var selectedImageScale: Image.Scale = .medium
    @State private var selectedContentMode: ContentMode = .fit
    @State private var selectedImageOrientation: UIImage.Orientation = .up
    @State private var selectedImageResizingMode: Image.ResizingMode = .stretch
    @State private var selectedSymbolVariants = SymbolVariants.fill
    @State private var selectedSymbolEffect: SymbolEffectType = .pulse

    @State private var exampleImage = Image("example")
    @State private var symbolImage = Image(systemName: "bolt")
    @State private var cgImage: CGImage? = nil
    @State private var asyncImagePhaseString: String = "ready"

    @State private var showDescription: Bool = false
    @State private var showBorder: Bool = false
    @State private var showSymbolEffect: Bool = true
    @State private var showSymbolEffectsRemoved: Bool = true

    @State private var hideTabBar: Bool = false

    func createTriangleCGImage() -> CGImage? {
        let width = 200
        let height = 200
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(
            rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        guard
            let context = CGContext(
                data: nil,
                width: width,
                height: height,
                bitsPerComponent: 8,
                bytesPerRow: width * 4,
                space: colorSpace,
                bitmapInfo: bitmapInfo.rawValue
            )
        else { return nil }

        // 设置背景颜色为白色
        context.setFillColor(UIColor.white.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))

        // 设置三角形颜色
        context.setFillColor(UIColor.red.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(3)

        // 开始绘制三角形路径
        context.beginPath()
        context.move(to: CGPoint(x: width / 2 - 20, y: 20))  // 顶点
        context.addLine(to: CGPoint(x: 20, y: height - 50))  // 左下角
        context.addLine(to: CGPoint(x: width - 20, y: height - 20))  // 右下角
        context.closePath()  // 关闭路径（回到起点）

        // 填充并描边
        context.drawPath(using: .fillStroke)

        return context.makeImage()
    }

    func createRenderView() -> some View {
        Section {
            HStack {
                Spacer()
                VStack {
                    switch selectedSource {
                    case .local:
                        exampleImage
                            .resizable(
                                resizingMode: selectedImageResizingMode
                            )
                            .aspectRatio(
                                contentMode: selectedContentMode
                            )
                            .border(
                                showBorder
                                    ? Color.primary : Color.clear)
                    case .asyncImage:
                        AsyncImage(
                            url: URL(
                                string:
                                    "https://images.unsplash.com/photo-1737143765999-bd3be790ab4f?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            )
                        ) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .onAppear {
                                        withAnimation {
                                            asyncImagePhaseString = "Loading"
                                        }
                                    }
                            case .success(let image):
                                image
                                    .resizable(
                                        resizingMode:
                                            selectedImageResizingMode
                                    )
                                    .aspectRatio(
                                        contentMode: selectedContentMode
                                    )
                                    .border(
                                        showBorder
                                            ? Color.primary
                                            : Color.clear
                                    )
                                    .onAppear {
                                        withAnimation {
                                            asyncImagePhaseString = "Loaded"
                                        }
                                    }
                            case .failure(let error):
                                Image(
                                    systemName:
                                        "photo.badge.exclamationmark"
                                )
                                .font(.title)
                                Text(error.localizedDescription)
                                    .onAppear {
                                        withAnimation {
                                            asyncImagePhaseString = "Error"
                                        }
                                    }
                            @unknown default:
                                Color.orange.opacity(0.3)
                            }
                        }
                    case .bitmap:
                        HStack {
                            Spacer()
                            if let cgImage = cgImage {
                                Image(
                                    uiImage: UIImage(
                                        cgImage: cgImage, scale: 1,
                                        orientation:
                                            selectedImageOrientation)
                                )
                                .resizable(
                                    resizingMode:
                                        selectedImageResizingMode
                                )
                                .aspectRatio(
                                    contentMode: selectedContentMode
                                )
                                .border(
                                    showBorder
                                        ? Color.primary : Color.clear)
                            }
                            Spacer()
                        }
                    case .symbol:
                        Image(systemName: "apple.logo")
                            .resizable(
                                resizingMode:
                                    selectedImageResizingMode
                            )
                            .aspectRatio(
                                contentMode: selectedContentMode
                            )
                            .border(
                                showBorder
                                    ? Color.primary : Color.clear)
                    }
                }
                .onAppear {
                    cgImage = createTriangleCGImage()
                }
                .frame(width: 200, height: 200)
                .overlay {
                    Rectangle()
                        .stroke(Color.accentColor, lineWidth: 2)
                }
                Spacer()
            }
        }
    }
    
    var listHeight: Double {
        switch selectedSource {
        case .local:
            280
        case .asyncImage:
            280
        case .bitmap:
            200
        case .symbol:
            360
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        HStack {
                            Spacer()
                            VStack {
                                switch selectedSource {
                                case .local:
                                    exampleImage
                                        .resizable(
                                            resizingMode:
                                                selectedImageResizingMode
                                        )
                                        .aspectRatio(
                                            contentMode: selectedContentMode
                                        )
                                        .border(
                                            showBorder
                                                ? Color.primary : Color.clear)
                                case .asyncImage:
                                    AsyncImage(
                                        url: URL(
                                            string:
                                                "https://images.unsplash.com/photo-1737143765999-bd3be790ab4f?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                        )
                                    ) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .onAppear {
                                                    withAnimation {
                                                        asyncImagePhaseString =
                                                            "Loading"
                                                    }
                                                }
                                        case .success(let image):
                                            image
                                                .resizable(
                                                    resizingMode:
                                                        selectedImageResizingMode
                                                )
                                                .aspectRatio(
                                                    contentMode:
                                                        selectedContentMode
                                                )
                                                .border(
                                                    showBorder
                                                        ? Color.primary
                                                        : Color.clear
                                                )
                                                .onAppear {
                                                    withAnimation {
                                                        asyncImagePhaseString =
                                                            "Loaded"
                                                    }
                                                }
                                        case .failure(let error):
                                            Image(
                                                systemName:
                                                    "photo.badge.exclamationmark"
                                            )
                                            .font(.title)
                                            Text(error.localizedDescription)
                                                .onAppear {
                                                    withAnimation {
                                                        asyncImagePhaseString =
                                                            "Error"
                                                    }
                                                }
                                        @unknown default:
                                            Color.orange.opacity(0.3)
                                        }
                                    }
                                case .bitmap:
                                    HStack {
                                        Spacer()
                                        if let cgImage = cgImage {
                                            Image(
                                                uiImage: UIImage(
                                                    cgImage: cgImage, scale: 1,
                                                    orientation:
                                                        selectedImageOrientation
                                                )
                                            )
                                            .resizable(
                                                resizingMode:
                                                    selectedImageResizingMode
                                            )
                                            .aspectRatio(
                                                contentMode: selectedContentMode
                                            )
                                            .border(
                                                showBorder
                                                    ? Color.primary
                                                    : Color.clear)
                                        }
                                        Spacer()
                                    }
                                case .symbol:
                                    Image(systemName: "apple.logo")
                                        .resizable(
                                            resizingMode:
                                                selectedImageResizingMode
                                        )
                                        .aspectRatio(
                                            contentMode: selectedContentMode
                                        )
                                        .border(
                                            showBorder
                                                ? Color.primary : Color.clear)
                                }
                            }
                            .onAppear {
                                cgImage = createTriangleCGImage()
                            }
                            .frame(width: 200, height: 200)
                            .overlay {
                                Rectangle()
                                    .stroke(Color.accentColor, lineWidth: 2)
                            }
                            Spacer()
                        }
                    }
                    if selectedSource == .symbol {
                        Section {
                            HStack {
                                switch selectedSymbolEffect {
                                case .appear:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                case .bounce:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                        .symbolEffect(
                                            .bounce, value: showSymbolEffect)
                                case .disappear:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                case .pulse:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                        .symbolEffect(
                                            .pulse, value: showSymbolEffect)
                                case .scale:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                case .variableColor:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                        .symbolEffect(
                                            .variableColor,
                                            value: showSymbolEffect)
                                case .breathe:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                        .symbolEffect(
                                            .breathe, value: showSymbolEffect)
                                case .rotate:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                        .symbolEffect(
                                            .rotate, value: showSymbolEffect)
                                case .wiggle:
                                    symbolImage
                                        .imageScale(selectedImageScale)
                                        .symbolVariant(selectedSymbolVariants)
                                        .symbolEffect(
                                            .wiggle, value: showSymbolEffect)
                                }
                                Text(
                                    "bolt."
                                        + selectedSymbolVariants.name
                                        .lowercased())
                            }
                        }
                    }
                }
                .scrollDisabled(true)
                .frame(height: listHeight)
                Divider()
                List {
                    Section("Control") {
                        Picker("Type", selection: $selectedSource.animation()) {
                            ForEach(SourceType.allCases) { type in
                                Text(type.name)
                            }
                        }

                        Toggle("Image Border", isOn: $showBorder.animation())

                        VStack(alignment: .leading) {
                            Picker(
                                "Content Mode",
                                selection: $selectedContentMode.animation()
                            ) {
                                ForEach(ContentMode.allCases, id: \.self) {
                                    mode in
                                    Text(mode.name)
                                }
                            }
                            if showDescription {
                                Text(
                                    "Constants that define how a view’s content fills the available space."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }

                        VStack(alignment: .leading) {
                            Picker(
                                "Resizing Mode",
                                selection:
                                    $selectedImageResizingMode.animation()
                            ) {
                                ForEach(Image.ResizingMode.allCases, id: \.self)
                                {
                                    mode in
                                    Text(mode.name)
                                }
                            }
                            if showDescription {
                                Text(
                                    "The modes that SwiftUI uses to resize an image to fit within its containing view."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }

                        if selectedSource == .symbol {
                            VStack(alignment: .leading) {
                                Picker(
                                    "ImageScale",
                                    selection: $selectedImageScale.animation()
                                ) {
                                    ForEach(Image.Scale.allCases, id: \.self) {
                                        scale in
                                        Text(scale.name)
                                    }
                                }
                                if showDescription {
                                    Text(
                                        "A scale to apply to vector images relative to text."
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        }

                        if selectedSource == .bitmap {
                            VStack(alignment: .leading) {
                                Picker(
                                    "Orientation",
                                    selection:
                                        $selectedImageOrientation.animation()
                                ) {
                                    ForEach(
                                        UIImage.Orientation.allCases, id: \.self
                                    ) { orientation in
                                        Text(orientation.name)
                                    }
                                }
                                if showDescription {
                                    Text("The orientation of an image.")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }

                        if selectedSource == .symbol {
                            VStack(alignment: .leading) {
                                Picker(
                                    "symbolVariant",
                                    selection: $selectedSymbolVariants
                                ) {
                                    ForEach(
                                        SymbolVariants.predefinedVariants,
                                        id: \.self
                                    ) {
                                        variant in
                                        switch variant {
                                        case SymbolVariants.circle:
                                            Button("Circle") {
                                                withAnimation {
                                                    selectedSymbolVariants =
                                                        .none
                                                }
                                            }
                                        case SymbolVariants.fill:
                                            Button("Fill") {
                                                withAnimation {
                                                    selectedSymbolVariants =
                                                        .none
                                                }
                                            }
                                        case SymbolVariants.rectangle:
                                            Button("Rectangle") {
                                                withAnimation {
                                                    selectedSymbolVariants =
                                                        .none
                                                }
                                            }
                                        case SymbolVariants.slash:
                                            Button("Slash") {
                                                withAnimation {
                                                    selectedSymbolVariants =
                                                        .none
                                                }
                                            }
                                        case SymbolVariants.square:
                                            Button("Square") {
                                                withAnimation {
                                                    selectedSymbolVariants =
                                                        .square
                                                }
                                            }
                                        case SymbolVariants.none:
                                            Button("None") {
                                                withAnimation {
                                                    selectedSymbolVariants =
                                                        .none
                                                }
                                            }
                                        default:
                                            Text("None")
                                        }
                                    }
                                }
                                if showDescription {
                                    Text(
                                        "Makes symbols within the view show a particular variant."
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        }

                        if selectedSource == .symbol {
                            Button("Show Symbol Effect") {
                                withAnimation {
                                    showSymbolEffect.toggle()
                                }
                            }
                        }
                    }

                    Section("Value") {
                        if selectedSource == .asyncImage {
                            LabeledContent(
                                "Phase", value: asyncImagePhaseString)
                        }
                    }
                }
            }
            .navigationTitle("Images")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Menu {
                    Toggle(isOn: $showDescription.animation()) {
                        Label("Show Description", systemImage: "eye")
                    }
                    let renderer = ImageRenderer(content: createRenderView())
                    if let image = renderer.cgImage {
                        ShareLink(
                            item: Image(uiImage: UIImage(cgImage: image)),
                            preview: SharePreview(
                                "Render Image",
                                image: Image(uiImage: UIImage(cgImage: image)))
                        ) {
                            Label("Render", systemImage: "printer.fill")
                        }
                    }
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
            }
            .toolbarVisibility(hideTabBar ? .hidden : .automatic, for: .tabBar)
            .onAppear {
                withAnimation {
                    hideTabBar = true
                }
            }
        }
    }
}

extension ContentMode {
    var name: String {
        switch self {
        case .fit:
            "Fit"
        case .fill:
            "Fill"
        }
    }
}

extension Image.Scale {
    static var allCases: [Image.Scale] {
        return [.small, .medium, .large]
    }

    var name: String {
        switch self {
        case .small:
            "Small"
        case .medium:
            "Medium"
        case .large:
            "Large"
        @unknown default:
            "Unknown"
        }
    }
}

extension Image.ResizingMode {
    static var allCases: [Image.ResizingMode] {
        return [.stretch, .tile]
    }

    var name: String {
        switch self {
        case .tile:
            "Tile"
        case .stretch:
            "Stretch"
        @unknown default:
            "Unknown ResizingMode"
        }
    }

    var description: String {
        switch self {
        case .tile:
            "A mode to repeat the image at its original size, as many times as necessary to fill the available space."
        case .stretch:
            "A mode to enlarge or reduce the size of an image so that it fills the available space."
        @unknown default:
            "Unknown ResizingMode Description"
        }
    }
}

extension UIImage.Orientation {
    static var allCases: [UIImage.Orientation] {
        return [
            .up, .upMirrored, .down, .downMirrored, .left, .leftMirrored,
            .right, .rightMirrored,
        ]
    }

    var name: String {
        switch self {
        case .up:
            "Up"
        case .down:
            "Down"
        case .left:
            "Left"
        case .right:
            "Right"
        case .upMirrored:
            "Up Mirrored"
        case .downMirrored:
            "Down Mirrored"
        case .leftMirrored:
            "Left Mirrored"
        case .rightMirrored:
            "Right Mirrored"
        @unknown default:
            "Unknown Orientation"
        }
    }
}

extension SymbolVariants {
    public static var predefinedVariants: [SymbolVariants] {
        return [.circle, .fill, .none, .rectangle, .slash, .square]
    }
    public var name: String {
        switch self {
        case .circle:
            return "Circle"
        case .fill:
            return "Fill"
        case .none:
            return "None"
        case .rectangle:
            return "Rectangle"
        case .slash:
            return "Slash"
        case .square:
            return "Square"
        default:
            return "None"
        }
    }
}

#Preview {
    ImagesView()
}
