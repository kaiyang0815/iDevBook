//
//  ShapesView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/29.
//
//

import SwiftUI

enum ShapeType: String, CaseIterable, Identifiable {
    case rectangle
    case roundedRectangle
    case unevenRoundedRectangle
    case circle
    case ellipse
    case capsule
    case path

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .rectangle:
            "Rectangle"
        case .roundedRectangle:
            "RoundedRectangle"
        case .unevenRoundedRectangle:
            "UnevenRoundedRectangle"
        case .circle:
            "Circle"
        case .ellipse:
            "Ellipse"
        case .capsule:
            "Capsule"
        case .path:
            "Path"
        }
    }

    var description: String {
        switch self {
        case .rectangle:
            "A rectangular shape aligned inside the frame of the view containing it."
        case .roundedRectangle:
            "A rectangular shape with rounded corners, aligned inside the frame of the view containing it."
        case .unevenRoundedRectangle:
            "A rectangular shape with rounded corners with different values, aligned inside the frame of the view containing it."
        case .circle:
            "A circle centered on the frame of the view containing it."
        case .ellipse:
            "An ellipse aligned inside the frame of the view containing it."
        case .capsule:
            "A capsule shape aligned inside the frame of the view containing it."
        case .path:
            "The outline of a 2D shape."
        }
    }
}

struct ShapesView: View {
    @State private var selectedShapeType: ShapeType = .rectangle
    @State private var selectedFillColor: Color = .orange
    @State private var selectedStrokeColor: Color = .black
    @State private var selectedRoundedCornerStyle: RoundedCornerStyle =
        .circular
    @State private var lineWidth: CGFloat = 0
    @State private var dash: [CGFloat] = [10, 5]
    @State private var dashPhase: CGFloat = 0
    @State private var lineCap: CGLineCap = .round
    @State private var lineJoin: CGLineJoin = .round

    @State private var isStrokeBorder: Bool = false
    @State private var showDescription: Bool = false
    @State private var showInspector: Bool = true
    @State private var size: CGSize = .zero

    // shape
    @State private var rectangle = Rectangle()
    @State private var roundedRectangle: RoundedRectangle = RoundedRectangle(
        cornerRadius: 12)
    @State private var unevenRoundedRectangle = UnevenRoundedRectangle(
        cornerRadii: .init(
            topLeading: 50.0,
            bottomLeading: 10.0,
            bottomTrailing: 50.0,
            topTrailing: 10.0
        ),
        style: .continuous
    )
    @State private var circle = Circle()
    @State private var ellipse = Ellipse()
    @State private var capsule = Capsule()
    @State private var hideTabBar: Bool = false

    let lineCapOptions: [(String, CGLineCap)] = [
        ("Butt", .butt),
        ("Round", .round),
        ("Square", .square),
    ]

    let lineJoinOptions: [(String, CGLineJoin)] = [
        ("Miter", .miter),
        ("Round", .round),
        ("Bevel", .bevel),
    ]

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        HStack {
                            switch selectedShapeType {
                            case .rectangle:
                                CardContainerView {
                                    rectangle
                                        .fill(selectedFillColor)
                                        .stroke(
                                            selectedStrokeColor,
                                            style: StrokeStyle(
                                                lineWidth: lineWidth,
                                                lineCap: lineCap,
                                                lineJoin: lineJoin,
                                                dash: dash,
                                                dashPhase: dashPhase
                                            ),
                                            antialiased: true
                                        )
                                }
                            case .roundedRectangle:
                                CardContainerView {
                                    roundedRectangle
                                        .fill(selectedFillColor)
                                        .stroke(
                                            selectedStrokeColor,
                                            style: StrokeStyle(
                                                lineWidth: lineWidth,
                                                lineCap: lineCap,
                                                lineJoin: lineJoin,
                                                dash: dash,
                                                dashPhase: dashPhase
                                            ),
                                            antialiased: true
                                        )
                                }
                            case .unevenRoundedRectangle:
                                CardContainerView {
                                    unevenRoundedRectangle
                                        .fill(selectedFillColor)
                                        .stroke(
                                            selectedStrokeColor,
                                            style: StrokeStyle(
                                                lineWidth: lineWidth,
                                                lineCap: lineCap,
                                                lineJoin: lineJoin,
                                                dash: dash,
                                                dashPhase: dashPhase
                                            ),
                                            antialiased: true
                                        )
                                }
                            case .circle:
                                CardContainerView {
                                    HStack {
                                        Spacer()
                                        circle
                                            .fill(selectedFillColor)
                                            .stroke(
                                                selectedStrokeColor,
                                                style: StrokeStyle(
                                                    lineWidth: lineWidth,
                                                    lineCap: lineCap,
                                                    lineJoin: lineJoin,
                                                    dash: dash,
                                                    dashPhase: dashPhase
                                                ),
                                                antialiased: true
                                            )
                                        Spacer()
                                    }
                                }
                            case .ellipse:
                                CardContainerView {
                                    ellipse
                                        .fill(selectedFillColor)
                                        .stroke(
                                            selectedStrokeColor,
                                            style: StrokeStyle(
                                                lineWidth: lineWidth,
                                                lineCap: lineCap,
                                                lineJoin: lineJoin,
                                                dash: dash,
                                                dashPhase: dashPhase
                                            ),
                                            antialiased: true
                                        )
                                }
                            case .capsule:
                                CardContainerView {
                                    capsule
                                        .fill(selectedFillColor)
                                        .stroke(
                                            selectedStrokeColor,
                                            style: StrokeStyle(
                                                lineWidth: lineWidth,
                                                lineCap: lineCap,
                                                lineJoin: lineJoin,
                                                dash: dash,
                                                dashPhase: dashPhase
                                            ),
                                            antialiased: true
                                        )
                                }
                            case .path:
                                CardContainerView {
                                    Path { path in
                                        path.move(
                                            to: CGPoint(
                                                x: proxy.size.width / 2, y: 20))
                                        path.addLine(
                                            to: CGPoint(
                                                x: proxy.size.width / 2 - 100,
                                                y: proxy.size.height - 20))
                                        path.addLine(
                                            to: CGPoint(
                                                x: proxy.size.width / 2 + 100,
                                                y: proxy.size.height - 20))
                                        path.closeSubpath()
                                    }
                                    .fill(selectedFillColor)
                                    .stroke(
                                        selectedStrokeColor,
                                        style: StrokeStyle(
                                            lineWidth: lineWidth,
                                            lineCap: lineCap,
                                            lineJoin: lineJoin,
                                            dash: dash,
                                            dashPhase: dashPhase
                                        ),
                                        antialiased: true
                                    )
                                }
                            }
                        }
                        .frame(height: size.height / 4)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                .task {
                    size = proxy.size
                }
                .onTapGesture(count: 2) {
                    withAnimation {
                        showInspector.toggle()
                    }
                }
            }
            .navigationTitle("Shapes")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .inspector(
                isPresented: $showInspector,
                content: {
                    List {
                        Section {
                            Picker("Type", selection: $selectedShapeType) {
                                ForEach(ShapeType.allCases) { type in
                                    Text(type.name)
                                }
                            }
                        } footer: {
                            if showDescription {
                                Text(selectedShapeType.description)
                            }
                        }
                        Section("Control") {
                            ColorPicker(".fill", selection: $selectedFillColor)
                            ColorPicker(
                                ".stroke", selection: $selectedStrokeColor)
                            LabeledContent {
                                Slider(
                                    value: $lineWidth, in: 0...10,
                                    step: 1
                                )
                            } label: {
                                Text("lineWidth")
                                Text(lineWidth, format: .number)
                            }

                            Stepper(
                                value: Binding(
                                    get: { dash[0] },
                                    set: { dash[0] = $0 }
                                ), in: 0...50, step: 1
                            ) {
                                Text("short")
                                Text(dash[0], format: .number)
                            }

                            Stepper(
                                value: Binding(
                                    get: { dash.count > 1 ? dash[1] : 0 },
                                    set: { if dash.count > 1 { dash[1] = $0 } }
                                ), in: 0...50, step: 1
                            ) {
                                Text("long")
                                Text(
                                    Int(dash.count > 1 ? dash[1] : 0),
                                    format: .number)
                            }

                            Slider(value: $dashPhase, in: 0...50, step: 1)

                            Picker("lineCap", selection: $lineCap) {
                                ForEach(lineCapOptions, id: \.1) { option in
                                    Text(option.0).tag(option.1)
                                }
                            }

                            Picker("lineJoin", selection: $lineJoin) {
                                ForEach(lineJoinOptions, id: \.1) { option in
                                    Text(option.0).tag(option.1)
                                }
                            }
                            if selectedShapeType == .unevenRoundedRectangle {
                                LabeledContent {
                                    Slider(
                                        value: $unevenRoundedRectangle
                                            .cornerRadii
                                            .topLeading, in: 0...100, step: 1)
                                } label: {
                                    Image(
                                        systemName:
                                            "inset.filled.topleading.rectangle")
                                }
                                LabeledContent {
                                    Slider(
                                        value: $unevenRoundedRectangle
                                            .cornerRadii
                                            .topTrailing, in: 0...100, step: 1)
                                } label: {
                                    Image(
                                        systemName:
                                            "inset.filled.toptrailing.rectangle"
                                    )
                                }
                                LabeledContent {
                                    Slider(
                                        value: $unevenRoundedRectangle
                                            .cornerRadii
                                            .bottomLeading, in: 0...100, step: 1
                                    )
                                } label: {
                                    Image(
                                        systemName:
                                            "inset.filled.bottomleading.rectangle"
                                    )
                                }
                                LabeledContent {
                                    Slider(
                                        value: $unevenRoundedRectangle
                                            .cornerRadii
                                            .bottomTrailing, in: 0...100,
                                        step: 1)
                                } label: {
                                    Image(
                                        systemName:
                                            "inset.filled.bottomtrailing.rectangle"
                                    )
                                }
                            }
                        }
                        Section("Value") {
                            if selectedShapeType == .roundedRectangle {
                                LabeledContent(
                                    "cornerSize.width",
                                    value: roundedRectangle.cornerSize.width,
                                    format: .number)
                                LabeledContent(
                                    "cornerSize.height",
                                    value: roundedRectangle.cornerSize.height,
                                    format: .number)
                                LabeledContent(
                                    "style",
                                    value: roundedRectangle.style == .circular
                                        ? "Circular" : "Continuous")
                            }
                            if selectedShapeType == .unevenRoundedRectangle {
                                LabeledContent(
                                    "cornerRadii.topLeading",
                                    value: unevenRoundedRectangle.cornerRadii
                                        .topLeading, format: .number)
                                LabeledContent(
                                    "cornerRadii.topTrailing",
                                    value: unevenRoundedRectangle.cornerRadii
                                        .topTrailing, format: .number)
                                LabeledContent(
                                    "cornerRadii.bottomLeading",
                                    value: unevenRoundedRectangle.cornerRadii
                                        .bottomLeading, format: .number)
                                LabeledContent(
                                    "cornerRadii.bottomTrailing",
                                    value: unevenRoundedRectangle.cornerRadii
                                        .bottomTrailing, format: .number)
                                LabeledContent(
                                    "style",
                                    value: unevenRoundedRectangle.style
                                        == .circular
                                        ? "Circular" : "Continuous")
                            }
                            if selectedShapeType == .capsule {
                                LabeledContent(
                                    "style",
                                    value: capsule.style == .circular
                                        ? "Circular" : "Continuous")
                            }
                        }
                    }
                }
            )
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
                }
            }
            #if os(iOS)
                .onWillDisappear {
                    withAnimation {
                        showInspector = false
                    }
                }
            #endif
        }
    }
}

#Preview {
    ShapesView()
}
