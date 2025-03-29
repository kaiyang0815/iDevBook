//
//  CanvasView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import PencilKit
import SwiftUI

struct DrawingCanvas: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    @Binding var backgroundColor: Color
    @Binding var drawingPolicy: DrawingPolicy
    @Binding var toolPickerVisible: Bool

    private let canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.delegate = context.coordinator
        canvasView.drawingPolicy = drawingPolicy.policy
        canvasView.backgroundColor = UIColor(backgroundColor)

        toolPicker.setVisible(toolPickerVisible, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)

        if toolPickerVisible {
            canvasView.becomeFirstResponder()
        }

        return canvasView
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        if drawing != canvasView.drawing {
            canvasView.drawing = drawing
        }
        
        canvasView.backgroundColor = UIColor(backgroundColor)
        canvasView.drawingPolicy = drawingPolicy.policy
        
        toolPicker.setVisible(toolPickerVisible, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)

        if toolPickerVisible {
            canvasView.becomeFirstResponder()
        } else {
            canvasView.resignFirstResponder()
        }
    }

    class Coordinator: NSObject, PKCanvasViewDelegate {
        var drawing: Binding<PKDrawing>

        init(drawing: Binding<PKDrawing>) {
            self.drawing = drawing
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            drawing.wrappedValue = canvasView.drawing
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(drawing: $drawing)
    }
}

enum DrawingPolicy: String, CaseIterable, Identifiable {
    case anyInput
    case pencilOnly
    case `default`

    var id: Self { self }

    var policy: PKCanvasViewDrawingPolicy {
        switch self {
        case .anyInput:
            .anyInput
        case .pencilOnly:
            .pencilOnly
        case .default:
            .default
        }
    }

    var name: String {
        switch self {
        case .anyInput:
            ".anyInput"
        case .pencilOnly:
            ".pencilOnly"
        case .default:
            ".defatult"
        }
    }
}

struct PencilKitCanvasView: View {
    @State private var showInspector: Bool = true
    @State private var hideTabBar: Bool = true
    @State private var showDescription: Bool = true

    @State private var canvasView = PKCanvasView()
    @State private var drawing = PKDrawing()
    @State private var size: CGSize = .zero
    @State private var backgroundColor: Color = .white
    @State private var drawingPolicy: DrawingPolicy = .anyInput
    @State private var toolPickerVisible: Bool = false

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        CardContainerView {
                            DrawingCanvas(
                                drawing: $drawing,
                                backgroundColor: $backgroundColor,
                                drawingPolicy: $drawingPolicy,
                                toolPickerVisible: $toolPickerVisible
                            )
                            .frame(height: size.height / 4)
                        }
                    }
                    .clearSectionStyle()
                    .task {
                        size = proxy.size
                    }
                }
                .onTapGesture(count: 2) {
                    withAnimation {
                        showInspector.toggle()
                    }
                }
            }
            .navigationTitle("Canvas")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .inspector(isPresented: $showInspector) {
                Form {
                    Section("Control") {
                        ColorPicker(
                            "backgroundColor", selection: $backgroundColor)
                        WithDescriptionView(
                            showDescription: $showDescription,
                            description:
                                "The policy that controls the types of touches allowed when drawing on the canvas."
                        ) {
                            Picker("drawingPolicy", selection: $drawingPolicy)
                            {
                                ForEach(DrawingPolicy.allCases) {
                                    policy in
                                    Text(policy.name)
                                        .tag(policy)
                                }
                            }
                        }
                        Toggle(isOn: $toolPickerVisible) {
                            Text("toolPickerVisible")
                        }
                        Button {
                            withAnimation {
                                drawing = PKDrawing()
                            }
                        } label: {
                            Label("Delete all", systemImage: "trash")
                        }
                    }
                    Section("Value") {
                        Image(
                            uiImage: drawing.image(
                                from: drawing.bounds, scale: 1)
                        )
                        .frame(height: size.height / 4)
                    }
                }
            }
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
        }
    }
}

#Preview {
    PencilKitCanvasView()
}
