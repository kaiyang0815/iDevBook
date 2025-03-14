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
    @State private var selectedFillColor: Color = Color.black
    @State private var selectedStrokeColor: Color = Color.blue
    @State private var selectedRoundedCornerStyle: RoundedCornerStyle =
        .circular
    @State private var selectedStrokeWidth: CGFloat = 0
    @State private var selectedStrokeDash: [CGFloat] = [10]

    @State private var isStrokeBorder: Bool = false
    @State private var showDescription: Bool = false
    @State private var showInspector: Bool = false

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

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                GeometryReader { proxy in
                    VStack {
                        switch selectedShapeType {
                        case .rectangle:
                            rectangle
                                .fill(selectedFillColor)
                                //                                    .stroke(
                                //                                        selectedStrokeColor,
                                //                                        lineWidth: selectedStrokeWidth)
                                .stroke(
                                    selectedStrokeColor,
                                    style: StrokeStyle(
                                        lineWidth: selectedStrokeWidth,
                                        dash: selectedStrokeDash,
                                        dashPhase: 4
                                    ),
                                    antialiased: true
                                )
                        case .roundedRectangle:
                            roundedRectangle
                                .fill(selectedFillColor)
                                .stroke(
                                    selectedStrokeColor,
                                    lineWidth: selectedStrokeWidth)
                        case .unevenRoundedRectangle:
                            unevenRoundedRectangle
                                .fill(selectedFillColor)
                                .stroke(
                                    selectedStrokeColor,
                                    lineWidth: selectedStrokeWidth)
                        case .circle:
                            HStack {
                                Spacer()
                                circle
                                    .fill(selectedFillColor)
                                    .stroke(
                                        selectedStrokeColor,
                                        lineWidth: selectedStrokeWidth)
                                Spacer()
                            }
                        case .ellipse:
                            ellipse
                                .fill(selectedFillColor)
                                .stroke(
                                    selectedStrokeColor,
                                    lineWidth: selectedStrokeWidth)
                        case .capsule:
                            capsule
                                .fill(selectedFillColor)
                                .stroke(
                                    selectedStrokeColor,
                                    lineWidth: selectedStrokeWidth)
                        case .path:
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
                                lineWidth: selectedStrokeWidth)
                        }
                    }
                }
            }
            .navigationTitle("Shapes")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarVisibility(hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .inspector(isPresented: $showInspector, content: {
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
                        ColorPicker(".stroke", selection: $selectedStrokeColor)
                        LabeledContent("lineWidth") {
                            Slider(
                                value: $selectedStrokeWidth, in: 0...10, step: 1
                            )
                        }

                        if selectedShapeType == .unevenRoundedRectangle {
                            LabeledContent {
                                Slider(
                                    value: $unevenRoundedRectangle.cornerRadii
                                        .topLeading, in: 0...100, step: 1)
                            } label: {
                                Image(
                                    systemName:
                                        "inset.filled.topleading.rectangle")
                            }
                            LabeledContent {
                                Slider(
                                    value: $unevenRoundedRectangle.cornerRadii
                                        .topTrailing, in: 0...100, step: 1)
                            } label: {
                                Image(
                                    systemName:
                                        "inset.filled.toptrailing.rectangle"
                                )
                            }
                            LabeledContent {
                                Slider(
                                    value: $unevenRoundedRectangle.cornerRadii
                                        .bottomLeading, in: 0...100, step: 1)
                            } label: {
                                Image(
                                    systemName:
                                        "inset.filled.bottomleading.rectangle")
                            }
                            LabeledContent {
                                Slider(
                                    value: $unevenRoundedRectangle.cornerRadii
                                        .bottomTrailing, in: 0...100, step: 1)
                            } label: {
                                Image(
                                    systemName:
                                        "inset.filled.bottomtrailing.rectangle")
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
                                value: unevenRoundedRectangle.style == .circular
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
            })
            .toolbar {
                Menu {
                    Toggle(isOn: $showDescription.animation()) {
                        Label("Show Description", systemImage: "eye")
                    }
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
                Button {
                    withAnimation {
                        showInspector.toggle()
                    }
                } label: {
                    Label("Show Inspector", systemImage: "sidebar.right")
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

#Preview {
    ShapesView()
}
