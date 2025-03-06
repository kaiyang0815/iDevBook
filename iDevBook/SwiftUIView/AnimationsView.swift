//
//  AnimationsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/2/1.
//
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Double
    var label: String
    var range: ClosedRange<Double>
    var step: Double

    var body: some View {
        Stepper {
            Text(label)
            Text(value, format: .number)
        } onIncrement: {
            withAnimation {
                value = min(value + step, range.upperBound)
            }
        } onDecrement: {
            withAnimation {
                value = max(value - step, range.lowerBound)
            }
        }
    }
}

struct DescriptionTextView: View {
    let content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

enum AnimationType: String, CaseIterable, Identifiable {
    case `default`
    case spring
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case bouncy
    case smooth
    case snappy
    case interactiveSpring
    case custom

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .default:
            "Default"
        case .spring:
            "Spring"
        case .linear:
            "Linear"
        case .easeIn:
            "Ease In"
        case .easeOut:
            "Ease Out"
        case .easeInOut:
            "Ease In Out"
        case .bouncy:
            "Bouncy"
        case .smooth:
            "Smooth"
        case .snappy:
            "Snappy"
        case .interactiveSpring:
            "Interactive Spring"
        case .custom:
            "Custom"
        }
    }

    var description: String {
        switch self {
        case .default:
            "A default animation instance."
        case .spring:
            ""
        case .linear:
            "An animation that moves at a constant speed."
        case .easeIn:
            "An animation that starts slowly and then increases speed towards the end of the movement."
        case .easeOut:
            "An animation that starts quickly and then slows towards the end of the movement."
        case .easeInOut:
            "An animation that combines the behaviors of in and out easing animations."
        case .bouncy:
            "A spring animation with a predefined duration and higher amount of bounce that can be tuned."
        case .smooth:
            "A smooth spring animation with a predefined duration and no bounce that can be tuned."
        case .snappy:
            "A spring animation with a predefined duration and small amount of bounce that feels more snappy and can be tuned."
        case .interactiveSpring:
            ""
        case .custom:
            ""
        }
    }
}

struct AnimationsView: View {
    @State private var selectedAnimationType: AnimationType = .default
    @State private var showDescription: Bool = false

    @State private var showSpacer: Bool = false
    @State private var showSpacer2: Bool = false
    @State private var showVS: Bool = false
    @State private var largeRadius: Bool = false

    @State private var animationDelay: Double = 0.0
    @State private var animationSpeed: Double = 1.0
    @State private var animationRepeatCount: Int = 1
    @State private var animationAutoreverses: Bool = true

    @State private var linearAnimationDuration: Double = 0.35
    @State private var easeInAnimationDuration: Double = 0.35
    @State private var easeOutAnimationDuration: Double = 0.35
    @State private var easeInOutAnimationDuration: Double = 0.35

    @State private var bouncyAnimationDuration: Double = 0.5
    @State private var bouncyExtraBounce: Double = 0.0

    @State private var smoothAnimationDuration: Double = 0.5
    @State private var smoothExtraBounce: Double = 0.0

    @State private var snappyAnimationDuration: Double = 0.5
    @State private var snappyExtraBounce: Double = 0.0

    @State private var springAnimationDuration: Double = 0.5
    @State private var springAnimationBounce: Double = 0.0
    
    @State private var offseX: CGFloat = 180
    @State private var hideTabBar: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        VStack {
                            HStack {
                                if showSpacer {
                                    Spacer()
                                }
                                RoundedRectangle(
                                    cornerRadius: largeRadius ? 50 : 12
                                )
                                .fill(.green.gradient)
                                .frame(
                                    width: 100, height: 100, alignment: .center
                                )
                                .onTapGesture {
                                    switch selectedAnimationType {
                                    case .default:
                                        withAnimation(
                                            .default
                                                .delay(animationDelay)
                                                .speed(animationSpeed)
                                                .repeatCount(
                                                    animationRepeatCount,
                                                    autoreverses:
                                                        animationAutoreverses)
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .spring:
                                        withAnimation(
                                            .spring(
                                                duration:
                                                    springAnimationDuration,
                                                bounce: springAnimationBounce
                                            )
                                            .delay(animationDelay)
                                            .speed(animationSpeed)
                                            .repeatCount(
                                                animationRepeatCount,
                                                autoreverses:
                                                    animationAutoreverses)
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .linear:
                                        withAnimation(
                                            .linear(
                                                duration:
                                                    linearAnimationDuration)
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .easeIn:
                                        withAnimation(
                                            .easeIn(
                                                duration:
                                                    easeInAnimationDuration)
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .easeOut:
                                        withAnimation(
                                            .easeOut(
                                                duration:
                                                    easeOutAnimationDuration)
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .easeInOut:
                                        withAnimation(
                                            .easeInOut(
                                                duration:
                                                    easeInOutAnimationDuration
                                            )
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .bouncy:
                                        withAnimation(
                                            .bouncy(
                                                duration:
                                                    bouncyAnimationDuration,
                                                extraBounce: bouncyExtraBounce
                                            )
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .smooth:
                                        withAnimation(
                                            .smooth(
                                                duration:
                                                    smoothAnimationDuration,
                                                extraBounce: smoothExtraBounce
                                            )
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .snappy:
                                        withAnimation(
                                            .snappy(
                                                duration:
                                                    snappyAnimationDuration,
                                                extraBounce: snappyExtraBounce
                                            )
                                        ) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .interactiveSpring:
                                        withAnimation(.interactiveSpring) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    case .custom:
                                        withAnimation(.linear(duration: 2)) {
                                            showSpacer.toggle()
                                            largeRadius.toggle()
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 180)
                    } header: {
                        Text("Preview")
                    } footer: {
                        if showVS {
                            Text("The blow is always default animation.")
                        }
                    }
                }
                .scrollDisabled(true)
                .frame(height: 280)

                Divider()
                List {
                    Section {
                        Picker(
                            "Type",
                            selection: $selectedAnimationType.animation()
                        ) {
                            ForEach(AnimationType.allCases, id: \.id) {
                                type in
                                Text(type.name).tag(type)
                            }
                        }
                        .onChange(of: selectedAnimationType) { _, _ in
                            withAnimation {
                                showSpacer = false
                                largeRadius = false
                            }
                        }
                    } footer: {
                        if showDescription {
                            Text(selectedAnimationType.description)
                        }
                    }

                    Section("Control") {
                        VStack(alignment: .leading) {
                            CustomStepper(
                                value: $animationDelay, label: ".delay",
                                range: 0...10, step: 0.5)
                            if showDescription {
                                DescriptionTextView(
                                    "Delays the start of the animation by the specified number of seconds."
                                )
                            }
                        }
                        VStack(alignment: .leading) {
                            CustomStepper(
                                value: $animationSpeed, label: ".speed",
                                range: 0...5, step: 0.25)
                            if showDescription {
                                DescriptionTextView(
                                    "Changes the duration of an animation by adjusting its speed."
                                )
                            }
                        }

                        Stepper {
                            Text("RepeatCount")
                            Text(animationRepeatCount, format: .number)
                        } onIncrement: {
                            withAnimation {
                                animationRepeatCount += 1
                                if animationRepeatCount >= 10 {
                                    animationRepeatCount = 10
                                }
                            }
                        } onDecrement: {
                            withAnimation {
                                animationRepeatCount -= 1
                                if animationRepeatCount < 0 {
                                    animationRepeatCount = 0
                                }
                            }
                        }

                        if selectedAnimationType == .spring {
                            CustomStepper(
                                value: $springAnimationDuration,
                                label: "Duration",
                                range: 0...10,
                                step: 0.5
                            )
                            CustomStepper(
                                value: $springAnimationBounce,
                                label: "Bounce",
                                range: -1...1,
                                step: 0.1
                            )
                        }

                        if selectedAnimationType == .linear {
                            CustomStepper(
                                value: $linearAnimationDuration,
                                label: "Duration",
                                range: 0...2,
                                step: 0.05
                            )
                        }

                        if selectedAnimationType == .easeIn {
                            CustomStepper(
                                value: $easeInAnimationDuration,
                                label: "Duration",
                                range: 0...2,
                                step: 0.05
                            )
                        }

                        if selectedAnimationType == .easeOut {
                            CustomStepper(
                                value: $easeOutAnimationDuration,
                                label: "Duration",
                                range: 0...2,
                                step: 0.05
                            )
                        }

                        if selectedAnimationType == .easeInOut {
                            CustomStepper(
                                value: $easeInOutAnimationDuration,
                                label: "Duration",
                                range: 0...2,
                                step: 0.05
                            )
                        }

                        if selectedAnimationType == .bouncy {
                            CustomStepper(
                                value: $bouncyAnimationDuration,
                                label: "Duration",
                                range: 0...2,
                                step: 0.05
                            )
                            CustomStepper(
                                value: $bouncyExtraBounce,
                                label: "ExtraBounce",
                                range: 0...2,
                                step: 0.1
                            )
                        }

                        if selectedAnimationType == .smooth {
                            CustomStepper(
                                value: $smoothAnimationDuration,
                                label: "Duration",
                                range: 0...2,
                                step: 0.05
                            )
                            CustomStepper(
                                value: $smoothExtraBounce,
                                label: "ExtraBounce",
                                range: 0...2,
                                step: 0.05
                            )
                        }

                        if selectedAnimationType == .snappy {
                            CustomStepper(
                                value: $snappyAnimationDuration,
                                label: "Duration",
                                range: 0...2,
                                step: 0.05
                            )
                            CustomStepper(
                                value: $snappyExtraBounce,
                                label: "ExtraBounce",
                                range: 0...2,
                                step: 0.05
                            )
                        }

                        Toggle("Autoreverses", isOn: $animationAutoreverses)
                    }

                    Section {
                        Button("Reset") {

                        }
                    }
                }
            }
            .navigationTitle("Animations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Menu {
                    Toggle(isOn: $showDescription.animation()) {
                        Label("Show Description", systemImage: "eye")
                    }
                    Toggle(isOn: $showVS.animation()) {
                        Label(
                            "Show Other",
                            systemImage: "rectangle.bottomhalf.filled")
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
    AnimationsView()
}
