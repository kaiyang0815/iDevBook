//
// DrawingandGraphicsView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum DGType: String, CaseIterable, Identifiable {
    case canvas
    case color
    case linearGradient
    case angularGradient
    case ellipticalGradient
    case radialGradient
    case meshGradient
    case material

    var name: String {
        switch self {
        case .canvas:
            "Canvas"
        case .color:
            "Color"
        case .linearGradient:
            "LinearGradient"
        case .meshGradient:
            "MeshGradient"
        case .material:
            "AnyGradient"
        case .angularGradient:
            "AngularGradient"
        case .ellipticalGradient:
            "EllipticalGradient"
        case .radialGradient:
            "RadialGradient"
        }
    }

    var id: Self {
        return self
    }
}

enum InnerColor: String, CaseIterable, Identifiable {
    case black
    case blue
    case brown
    case clear
    case cyan
    case gray
    case green
    case indigo
    case mint
    case orange
    case pink
    case purple
    case red
    case teal
    case white
    case yellow

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .black:
            return "Black"
        case .white:
            return "White"
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        case .yellow:
            return "Yellow"
        case .orange:
            return "Orange"
        case .pink:
            return "Pink"
        case .purple:
            return "Purple"
        case .brown:
            return "Brown"
        case .gray:
            return "Gray"
        case .clear:
            return "Clear"
        case .cyan:
            return "Cyan"
        case .indigo:
            return "Indigo"
        case .mint:
            return "Mint"
        case .teal:
            return "Teal"
        }
    }

    var uiColor: Color {
        switch self {
        case .black:
            return .black
        case .white:
            return .white
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .pink:
            return .pink
        case .purple:
            return .purple
        case .brown:
            return .brown
        case .gray:
            return .gray
        case .clear:
            return .clear
        case .cyan:
            return .cyan
        case .indigo:
            return .indigo
        case .mint:
            return .mint
        case .teal:
            return .teal
        }
    }
}

enum MGColorSpace: String, CaseIterable, Identifiable {
    case device
    case perceptual

    var name: String {
        switch self {
        case .device:
            "Device"
        case .perceptual:
            "Perceptual"
        }
    }

    var id: Self {
        return self
    }

    var space: Gradient.ColorSpace {
        switch self {
        case .device:
            .device
        case .perceptual:
            .perceptual
        }
    }
}

extension ColorRenderingMode {
    static var allCases: [ColorRenderingMode] {
        return [.extendedLinear, .linear, .nonLinear]
    }

    var name: String {
        switch self {
        case .nonLinear:
            ".nonLinear"
        case .linear:
            ".linear"
        case .extendedLinear:
            ".extendedLinear"
        @unknown default:
            "Unknown"
        }
    }
}

enum AGUnitPoint: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    case center
    case top
    case bottom
    case leading
    case trailing
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing

    var name: String {
        switch self {
        case .center:
            ".center"
        case .top:
            ".top"
        case .bottom:
            ".bottom"
        case .leading:
            ".leading"
        case .trailing:
            ".trailing"
        case .topLeading:
            ".topLeading"
        case .topTrailing:
            ".topTrailing"
        case .bottomLeading:
            ".bottomLeading"
        case .bottomTrailing:
            ".bottomTrailing"
        }
    }

    var unitPoint: UnitPoint {
        switch self {
        case .center:
            .center
        case .top:
            .top
        case .bottom:
            .bottom
        case .leading:
            .leading
        case .trailing:
            .trailing
        case .topLeading:
            .topLeading
        case .topTrailing:
            .topTrailing
        case .bottomLeading:
            .bottomLeading
        case .bottomTrailing:
            .bottomTrailing
        }
    }
}

struct DrawingandGraphicsView: View {
    @State private var selectedDGType: DGType = .angularGradient
    @State private var showDescription: Bool = false
    @State private var hideTabBar: Bool = false
    @State private var selectedInnerColor: InnerColor = .black

    @State private var useTint: Bool = false
    @State private var useColorGradient: Bool = false
    @State private var meshGradientHeight: Int = 3
    @State private var meshGradientWidth: Int = 3
    @State private var meshGradientPoints: [SIMD2<Float>] = []
    @State private var meshGradientBackground: Color = .gray
    @State private var meshGradientSmoothsColors: Bool = false
    @State private var meshGradientColorSpace: MGColorSpace = .device
    @State private var showMeshGradientPointsController: Bool = false

    @State private var showCanvasBorder: Bool = false
    @State private var canvasIsOpaque: Bool = false
    @State private var canvasFillColor: Color = .red
    @State private var canvasStrokeColor: Color = .blue
    @State private var canvasColorRenderingMode: ColorRenderingMode = .nonLinear

    @State private var linearGradientStopsCount: Int = 2
    
    @State private var angularGradientStopsCount: Int = 5
    @State private var angularGradientCenter: AGUnitPoint = .center
    @State private var angularStartAngle: Double = 0.0
    @State private var angularEndAngle: Double = 360.0

    private func generatePoints(_ width: Int, _ height: Int) -> [SIMD2<Float>] {
        var points: [SIMD2<Float>] = []

        for x in 0..<width {
            for y in 0..<height {
                let xPos = Float(x) / Float(width - 1)
                let yPos = Float(y) / Float(height - 1)

                let point = SIMD2<Float>(xPos, yPos)
                points.append(point)
            }
        }
        print(points)
        return points
    }

    private func generateMeshGradientColors(_ width: Int, _ height: Int)
        -> [Color]
    {
        var colors: [Color] = []

        for x in 0..<width {
            for y in 0..<height {
                let red = Float(x) / Float(width - 1)
                let green = Float(y) / Float(height - 1)
                let blue = 1.0 - red

                let color = Color(
                    red: Double(red),
                    green: Double(green),
                    blue: Double(blue),
                    opacity: 1.0
                )

                colors.append(color)
            }
        }

        return colors
    }

    private func generateStops(_ count: Int) -> [Gradient.Stop] {
        guard count > 1 else {
            return [.init(color: .red, location: 0.0)]
        }

        let colors: [Color] = [
            .red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink,
        ]
        var stops: [Gradient.Stop] = []

        for i in 0..<count {
            let location = Double(i) / Double(count - 1)
            let colorIndex = i % colors.count
            stops.append(.init(color: colors[colorIndex], location: location))
        }

        return stops
    }

    var body: some View {
        //        let points = Binding<[SIMD2<Float>]>(
        //            get: {
        //                return self.meshGradientPoints
        //            },
        //            set: {
        //                self.meshGradientPoints = $0
        //            })
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section("Preview") {
                        switch selectedDGType {
                        case .canvas:
                            Canvas(
                                opaque: canvasIsOpaque,
                                colorMode: canvasColorRenderingMode
                            ) { context, size in
                                var maskedContext = context
                                let halfSize = size.applying(
                                    CGAffineTransform(scaleX: 0.5, y: 0.5))
                                maskedContext.clip(
                                    to: Path(
                                        CGRect(origin: .zero, size: halfSize)))
                                maskedContext.fill(
                                    Path(
                                        ellipseIn: CGRect(
                                            origin: .zero, size: size)),
                                    with: .color(canvasFillColor))

                                let origin = CGPoint(
                                    x: size.width / 4, y: size.height / 4)
                                context.fill(
                                    Path(
                                        CGRect(origin: origin, size: halfSize)),
                                    with: .color(canvasFillColor))

                                let thridOrigin = CGPoint(
                                    x: size.width / 2, y: size.height / 2)
                                let thirdSize = size.applying(
                                    CGAffineTransform(scaleX: 0.4, y: 0.5))
                                context.stroke(
                                    Path(
                                        CGRect(
                                            origin: thridOrigin, size: thirdSize
                                        )), with: .color(canvasStrokeColor),
                                    lineWidth: 4)
                            }
                            .frame(height: 180)
                            .if(showCanvasBorder) { view in
                                view.border(Color.blue)
                            }
                        case .color:
                            Group {
                                if useColorGradient {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            selectedInnerColor.uiColor.gradient
                                        )
                                        .frame(height: 100)
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedInnerColor.uiColor)
                                        .frame(height: 100)
                                }
                            }
                        case .linearGradient:
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(
                                        stops: generateStops(
                                            linearGradientStopsCount),
                                        startPoint: .top, endPoint: .bottom)
                                )
                                .frame(height: 180)
                        case .meshGradient:
                            MeshGradient(
                                width: meshGradientWidth,
                                height: meshGradientHeight,
                                points: generatePoints(
                                    meshGradientWidth, meshGradientWidth),
                                colors: generateMeshGradientColors(
                                    meshGradientWidth, meshGradientWidth),
                                background: meshGradientBackground,
                                smoothsColors: meshGradientSmoothsColors,
                                colorSpace: meshGradientColorSpace.space
                            )
                            .frame(height: 180)
                        case .material:
                            Text("ca")
                        case .angularGradient:
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    AngularGradient(
                                        stops: generateStops(angularGradientStopsCount),
                                        center: angularGradientCenter.unitPoint,
                                        startAngle: Angle(degrees: angularStartAngle),
                                        endAngle: Angle(degrees: angularEndAngle)
                                    )
                                )
                                .frame(height: 180)
                        case .ellipticalGradient:
                            Text("ca")
                        case .radialGradient:
                            Text("ca")
                        }
                    }
                    if selectedDGType == .color {
                        Section {
                            Button("Click") {

                            }
                            .if(useTint) { view in
                                view.tint(selectedInnerColor.uiColor)
                            }
                        }
                    }
                }
                .scrollDisabled(true)
                .frame(height: 260)

                Divider()

                List {
                    Section {
                        Picker("Type", selection: $selectedDGType) {
                            ForEach(DGType.allCases) { type in
                                Text(type.name)
                                    .tag(type)
                            }
                        }
                    } footer: {
                        if showDescription {
                            switch selectedDGType {
                            case .canvas:
                                Text(
                                    "A view type that supports immediate mode drawing."
                                )
                            case .color:
                                Text(
                                    "A representation of a color that adapts to a given context."
                                )
                            case .linearGradient:
                                Text(
                                    "A color gradient represented as an array of color stops, each having a parametric location value."
                                )
                            case .meshGradient:
                                Text(
                                    "A two-dimensional gradient defined by a 2D grid of positioned colors."
                                )
                            case .material:
                                Text(
                                    "A color gradient."
                                )
                            case .angularGradient:
                                Text(
                                    "A color gradient."
                                )
                            case .ellipticalGradient:
                                Text(
                                    "A color gradient."
                                )
                            case .radialGradient:
                                Text(
                                    "A color gradient."
                                )
                            }
                        }
                    }
                    Section("Controll") {
                        switch selectedDGType {
                        case .canvas:
                            Toggle(isOn: $showCanvasBorder) {
                                Text("border")
                            }
                            Toggle(isOn: $canvasIsOpaque) {
                                Text("isOpaque")
                            }
                            ColorPicker(
                                "Fill Color", selection: $canvasFillColor)
                            ColorPicker(
                                "Stroke Color", selection: $canvasStrokeColor)
                            Picker(
                                "colorMode",
                                selection: $canvasColorRenderingMode
                            ) {
                                ForEach(ColorRenderingMode.allCases, id: \.self)
                                { mode in
                                    Text(mode.name)
                                }
                            }
                        case .color:
                            Picker("Colors", selection: $selectedInnerColor) {
                                ForEach(InnerColor.allCases) { color in
                                    Text(color.name)
                                        .tag(color)
                                }
                            }

                            Toggle(isOn: $useTint) {
                                Text(".tint")
                            }
                            if showDescription {
                                Text("Sets the tint color within this view.")
                            }

                            Toggle(isOn: $useColorGradient) {
                                Text(".gradient")
                            }
                            if showDescription {
                                Text("Sets the tint color within this view.")
                            }
                        case .linearGradient:
                            Stepper {
                                Text("Gradient stop count")
                                Text(linearGradientStopsCount, format: .number)
                            } onIncrement: {
                                linearGradientStopsCount += 1
                                if linearGradientStopsCount >= 10 {
                                    linearGradientStopsCount = 10
                                }
                            } onDecrement: {
                                linearGradientStopsCount -= 1
                                if linearGradientStopsCount < 1 {
                                    linearGradientStopsCount = 1
                                }
                            }
                        case .meshGradient:
                            Stepper {
                                Text("width")
                                Text(meshGradientWidth, format: .number)
                            } onIncrement: {
                                meshGradientWidth += 1
                                if meshGradientWidth >= 5 {
                                    meshGradientWidth = 5
                                }
                            } onDecrement: {
                                meshGradientWidth -= 1
                                if meshGradientWidth < 1 {
                                    meshGradientWidth = 1
                                }
                            }
                            Stepper {
                                Text("height")
                                Text(meshGradientHeight, format: .number)
                            } onIncrement: {
                                meshGradientHeight += 1
                                if meshGradientHeight >= 5 {
                                    meshGradientHeight = 5
                                }
                            } onDecrement: {
                                meshGradientHeight -= 1
                                if meshGradientHeight < 1 {
                                    meshGradientHeight = 1
                                }
                            }
                            ColorPicker(
                                "background", selection: $meshGradientBackground
                            )
                            Toggle(isOn: $meshGradientSmoothsColors) {
                                Text("smoothsColors")
                            }
                            Picker(
                                "colorSpace", selection: $meshGradientColorSpace
                            ) {
                                ForEach(MGColorSpace.allCases) { space in
                                    Text(space.name)
                                }
                            }
                        case .material:
                            Picker("Colors", selection: $selectedInnerColor) {
                                ForEach(InnerColor.allCases) { color in
                                    Text(color.name)
                                        .tag(color)
                                }
                            }

                            Toggle(isOn: $useTint) {
                                Text(".tint")
                            }
                            if showDescription {
                                Text("Sets the tint color within this view.")
                            }

                            Toggle(isOn: $useColorGradient) {
                                Text(".gradient")
                            }
                            if showDescription {
                                Text("Sets the tint color within this view.")
                            }
                        case .angularGradient:
                            Stepper {
                                Text("Gradient stop count")
                                Text(angularGradientStopsCount, format: .number)
                            } onIncrement: {
                                angularGradientStopsCount += 1
                                if angularGradientStopsCount >= 10 {
                                    angularGradientStopsCount = 10
                                }
                            } onDecrement: {
                                angularGradientStopsCount -= 1
                                if angularGradientStopsCount < 1 {
                                    angularGradientStopsCount = 1
                                }
                            }
                            Picker("center", selection: $angularGradientCenter) {
                                ForEach(AGUnitPoint.allCases) { unitPoint in
                                    Text(unitPoint.name)
                                }
                            }
                            LabeledContent {
                                Slider(value: $angularStartAngle, in: 0...360, step: 1) {
                                    Text("startAngle")
                                } minimumValueLabel: {
                                    Text("0")
                                } maximumValueLabel: {
                                    Text("360")
                                }
                            } label: {
                                Text("StartAngle")
                            }

                            LabeledContent {
                                Slider(value: $angularEndAngle, in: 0...360, step: 1) {
                                    Text("endAngle")
                                } minimumValueLabel: {
                                    Text("0")
                                } maximumValueLabel: {
                                    Text("360")
                                }
                            } label: {
                                Text("EndAngle")
                            }

                        case .ellipticalGradient:
                            Toggle(isOn: $useColorGradient) {
                                Text(".gradient")
                            }
                        case .radialGradient:
                            Toggle(isOn: $useColorGradient) {
                                Text(".gradient")
                            }
                        }
                        if selectedDGType == .meshGradient {
                            Toggle(isOn: $showMeshGradientPointsController) {
                                Text("Show Controller")
                            }
                        }
                    }
                    Section("Value") {
                        if selectedDGType == .color {
                            Text(selectedInnerColor.uiColor.description)
                        }
                    }
                }
            }
            .navigationTitle("Drawing and Graphics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Menu {
                    Toggle(isOn: $showDescription.animation()) {
                        Label("Show Description", systemImage: "eye")
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

#Preview {
    DrawingandGraphicsView()
}
