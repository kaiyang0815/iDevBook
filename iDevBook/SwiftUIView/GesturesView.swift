//
//  GesturesView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/29.
//
//

import SwiftUI

enum GestureType: String, CaseIterable, Identifiable {
    case tapGesture
    case spatialTapGesture
    case longPressGesture
    case dragGesture
    case windowDragGesture
    case magnifyGesture
    case rotateGesture

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .tapGesture:
            "TapGesture"
        case .spatialTapGesture:
            "SpatialTapGesture"
        case .longPressGesture:
            "LongPressGesture"
        case .dragGesture:
            "DragGesture"
        case .windowDragGesture:
            "WindowDragGesture"
        case .magnifyGesture:
            "MagnifyGesture"
        case .rotateGesture:
            "RotateGestrure"
        }
    }

    var description: String {
        switch self {
        case .tapGesture:
            "A gesture that recognizes one or more taps."
        case .spatialTapGesture:
            "A gesture that recognizes one or more taps and reports their location."
        case .longPressGesture:
            "A gesture that succeeds when the user performs a long press."
        case .dragGesture:
            "A dragging motion that invokes an action as the drag-event sequence changes."
        case .windowDragGesture:
            "A gesture that recognizes the motion of and handles dragging a window."
        case .magnifyGesture:
            "A gesture that recognizes a magnification motion and tracks the amount of magnification."
        case .rotateGesture:
            "A gesture that recognizes a rotation motion and tracks the angle of the rotation."
        }
    }
}

struct GesturesView: View {
    @State private var showDescription: Bool = false
    @State private var showInspector: Bool = false

    @State private var selectedGesture: GestureType = .tapGesture
    @State private var tapCount: Int = 0
    @State private var tapStep: Int = 1
    @State private var minimumDuration: Double = 0.5
    @State private var maximumDistance: Double = 10
    @State private var isDragging = false
    @State private var angle = Angle(degrees: 0.0)
    @State private var minimumAngleDelta = Angle(degrees: 1.0)
    @State private var location: CGPoint = .zero
    @State private var dragOffset: CGSize = .zero
    @State private var minimumDistance: CGFloat = 10
    @State private var minimumScaleDelta: CGFloat = 0.01

    @GestureState private var magnifyBy = 1.0
    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false
    @State private var hideTabBar: Bool = false

    var tapGesture: some Gesture {
        TapGesture(count: tapStep)
            .onEnded { _ in
                tapCount += 1
            }
    }

    var spatialTapGesture: some Gesture {
        SpatialTapGesture(count: tapStep)
            .onEnded { event in
                withAnimation {
                    self.location = event.location
                    tapCount += 1
                }
            }
    }

    var longPressGesture: some Gesture {
        LongPressGesture(
            minimumDuration: minimumDuration, maximumDistance: maximumDistance
        )
        .updating($isDetectingLongPress) {
            currentState, gestureState,
            transaction in
            gestureState = currentState
            transaction.animation = Animation.easeIn(duration: 2.0)
        }
        .onEnded { _ in
            tapCount += 1
        }
    }

    var dragGesture: some Gesture {
        DragGesture(minimumDistance: minimumDistance)
            .onChanged { value in
                withAnimation {
                    self.dragOffset = value.translation
                    self.isDragging = true
                }
            }
            .onEnded { _ in
                withAnimation {
                    self.dragOffset = .zero
                    self.isDragging = false
                    tapCount += 1
                }
            }
    }

    var magnifyGesture: some Gesture {
        MagnifyGesture(minimumScaleDelta: minimumScaleDelta)
            .updating($magnifyBy) { value, gestureState, transaction in
                withAnimation {
                    gestureState = value.magnification
                }
            }
    }

    var rotateGesture: some Gesture {
        RotateGesture(minimumAngleDelta: minimumAngleDelta)
            .onChanged { value in
                withAnimation {
                    angle = value.rotation
                }
            }
    }

    var body: some View {
        NavigationStack {
            VStack {
                switch selectedGesture {
                case .tapGesture:
                    RoundedRectangle(cornerRadius: 12)
                        .gesture(tapGesture)
                        .shadow(radius: 4)
                        .sensoryFeedback(
                            .success, trigger: tapCount)
                case .spatialTapGesture:
                    RoundedRectangle(cornerRadius: 12)
                        .gesture(spatialTapGesture)
                        .shadow(radius: 4)
                        .sensoryFeedback(
                            .success, trigger: tapCount)
                case .longPressGesture:
                    RoundedRectangle(cornerRadius: 12)
                        .gesture(longPressGesture)
                        .shadow(radius: 4)
                        .sensoryFeedback(
                            .success, trigger: tapCount)
                case .dragGesture:
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.secondary.opacity(0.35))
                            .frame(width: 50, height: 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        .secondary, lineWidth: 1)
                            }
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 50, height: 50)
                            .offset(
                                x: dragOffset.width,
                                y: dragOffset.height
                            )
                            .gesture(dragGesture)
                            .shadow(radius: 4)
                            .sensoryFeedback(
                                .success, trigger: tapCount)
                    }
                case .windowDragGesture:
                    #if os(iOS)
                        Text("macOS Only")
                    #endif
                case .magnifyGesture:
                    ZStack {
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 120, height: 120)
                            Spacer()
                        }
                        Image(
                            systemName:
                                "arrow.down.left.and.arrow.up.right"
                        )
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                    }
                    .gesture(magnifyGesture)
                    .scaleEffect(magnifyBy)
                    .shadow(radius: 4)
                case .rotateGesture:
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 60)
                        HStack {
                            Image(systemName: "arrowshape.up")
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "arrowshape.down")
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                    }
                    .gesture(rotateGesture)
                    .rotationEffect(angle)
                    .shadow(radius: 4)
                }
            }
            .navigationTitle("Gestures")
            .inspector(isPresented: $showInspector, content: {
                List {
                    Section {
                        Picker("Type", selection: $selectedGesture.animation())
                        {
                            ForEach(GestureType.allCases) { type in
                                Text(type.name)
                            }
                        }
                    } footer: {
                        if showDescription {
                            Text(selectedGesture.description)
                        }
                    }

                    Section("Control") {
                        switch selectedGesture {
                        case .tapGesture:
                            Stepper {
                                Text("count: \(tapStep)")
                            } onIncrement: {
                                tapStep += 1
                                if tapStep >= 10 { tapStep = 10 }
                            } onDecrement: {
                                tapStep -= 1
                                if tapStep < 1 { tapStep = 1 }
                            }
                            if showDescription {
                                Text(
                                    "Creates a tap gesture with the number of required taps."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        case .spatialTapGesture:
                            Stepper {
                                Text("count: \(tapStep)")
                            } onIncrement: {
                                tapStep += 1
                                if tapStep >= 10 { tapStep = 10 }
                            } onDecrement: {
                                tapStep -= 1
                                if tapStep < 1 { tapStep = 1 }
                            }
                            if showDescription {
                                Text(
                                    "Creates a tap gesture with the number of required taps."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        case .longPressGesture:
                            Stepper {
                                Text("minimumDuration")
                                Text(minimumDuration, format: .number)
                            } onIncrement: {
                                minimumDuration += 0.5
                                if minimumDuration >= 10 {
                                    minimumDuration = 10
                                }
                            } onDecrement: {
                                minimumDuration -= 0.5
                                if minimumDuration < 0.5 {
                                    minimumDuration = 0.5
                                }
                            }
                            if showDescription {
                                Text(
                                    "The minimum duration of the long press that must elapse before the gesture succeeds."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                            Stepper {
                                Text("maximumDistance")
                                Text(maximumDistance, format: .number)
                            } onIncrement: {
                                maximumDistance += 1
                                if maximumDistance >= 20 {
                                    maximumDistance = 20
                                }
                            } onDecrement: {
                                maximumDistance -= 1
                                if maximumDistance < 10 { maximumDistance = 10 }
                            }
                            if showDescription {
                                Text(
                                    "The maximum distance that the long press can move before the gesture fails."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        case .dragGesture:
                            Stepper {
                                Text("minimumDistance")
                                Text(minimumDistance, format: .number)
                            } onIncrement: {
                                minimumDistance += 1
                                if minimumDistance >= 20 {
                                    minimumDistance = 20
                                }
                            } onDecrement: {
                                minimumDistance -= 1
                                if minimumDistance < 10 { minimumDistance = 10 }
                            }
                            if showDescription {
                                Text(
                                    "The minimum dragging distance before the gesture succeeds."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        case .windowDragGesture:
                            Text("")
                        case .magnifyGesture:
                            Stepper {
                                Text("minimumScaleDelta")
                                Text(minimumScaleDelta, format: .number)
                            } onIncrement: {
                                minimumScaleDelta += 0.01
                                if minimumScaleDelta >= 0.1 {
                                    minimumScaleDelta = 0.1
                                }
                            } onDecrement: {
                                minimumScaleDelta -= 0.01
                                if minimumScaleDelta < 0.01 {
                                    minimumScaleDelta = 0.01
                                }
                            }
                            if showDescription {
                                Text(
                                    "The minimum required delta before the gesture starts."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        case .rotateGesture:
                            Stepper {
                                Text("minimumAngleDelta")
                                Text(minimumAngleDelta.degrees, format: .number)
                            } onIncrement: {
                                let newAngle = Angle(
                                    degrees: minimumAngleDelta.degrees + 1)
                                minimumAngleDelta = newAngle
                                if minimumAngleDelta.degrees >= 10 {
                                    minimumAngleDelta.degrees = 10
                                }
                            } onDecrement: {
                                let newAngle = Angle(
                                    degrees: minimumAngleDelta.degrees - 1)
                                minimumAngleDelta = newAngle
                                if minimumAngleDelta.degrees < 1 {
                                    minimumAngleDelta.degrees = 1
                                }
                            }
                            if showDescription {
                                Text(
                                    "Creates a rotation gesture with a minimum delta for the gesture to start."
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }

                    Section("Value") {
                        switch selectedGesture {
                        case .tapGesture:
                            LabeledContent(
                                "Tap Count", value: tapCount, format: .number)
                        case .spatialTapGesture:
                            LabeledContent(
                                "Tap Count", value: tapCount, format: .number)
                            LabeledContent(
                                "Tap Location X", value: location.x,
                                format: .number)
                            LabeledContent(
                                "Tap Location Y", value: location.y,
                                format: .number)
                        case .longPressGesture:
                            LabeledContent(
                                "Tap Count", value: tapCount, format: .number)
                        case .dragGesture:
                            LabeledContent(
                                "Draging", value: isDragging ? "True" : "False")
                            LabeledContent(
                                "Drag Offset X", value: dragOffset.width,
                                format: .number)
                            LabeledContent(
                                "Drag Offset Y", value: dragOffset.height,
                                format: .number)
                        case .windowDragGesture:
                            LabeledContent(
                                "Tap Count", value: tapCount, format: .number)
                        case .magnifyGesture:
                            LabeledContent(
                                "magnifyBy", value: magnifyBy, format: .number)
                        case .rotateGesture:
                            LabeledContent(
                                "Angle", value: angle.degrees, format: .number)
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
            #if os(iOS)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .onAppear {
                withAnimation {
                    hideTabBar = true
                }
            }
        }
    }
}

#Preview {
    GesturesView()
}
