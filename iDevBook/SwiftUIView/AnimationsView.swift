//
//  AnimationsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/2/1.
//
//

import SwiftUI

struct AnimationsView: View {
    @State private var selectedAnimationType: AnimationType = .spring
    @State private var selectedSpringType: SpringAnimationType = .type1

    @State private var showDescription: Bool = false
    @State private var showInspector: Bool = true
    @State private var showSpacer: Bool = false

    @State private var animationDelay: Double = 0.0
    @State private var animationSpeed: Double = 1.0
    @State private var animationRepeatCount: Int = 1
    @State private var animationAutoreverses: Bool = true
    @State private var animationDuration: Double = 0.5
    @State private var animationExtraBounce: Double = 0.0

    @State private var springAnimationDuration: Double = 0.5
    @State private var springAnimationBounce: Double = 0.0
    @State private var springAnimationBlendDuration: TimeInterval = 0.0
    @State private var springAnimationDampingFraction: Double = 0.825
    @State private var springAnimationResponse: Double = 0.5

    @State private var hideTabBar: Bool = false
    @State private var size: CGSize = .zero

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        CardContainerView {
                            HStack {
                                if showSpacer {
                                    Spacer()
                                }
                                RoundedRectangle(
                                    cornerRadius: 10
                                )
                                .fill(.green.gradient)
                                #if os(iOS)
                                    .frame(
                                        width: size.width / 4,
                                        height: size.width / 4)
                                #endif
                                if !showSpacer {
                                    Spacer()
                                }
                            }
                        }
                    }
                    .clearSectionStyle()
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
                            }
                        case .spring:
                            switch selectedSpringType {
                            case .type1:
                                withAnimation(
                                    .spring(
                                        Spring(
                                            duration: springAnimationDuration,
                                            bounce: springAnimationBounce),
                                        blendDuration:
                                            springAnimationBlendDuration
                                    )
                                    .delay(animationDelay)
                                    .speed(animationSpeed)
                                    .repeatCount(
                                        animationRepeatCount,
                                        autoreverses:
                                            animationAutoreverses)
                                ) {
                                    showSpacer.toggle()
                                }
                            case .type2:
                                withAnimation(
                                    .spring(
                                        duration:
                                            springAnimationDuration,
                                        bounce: springAnimationBounce,
                                        blendDuration:
                                            springAnimationBlendDuration
                                    )
                                    .delay(animationDelay)
                                    .speed(animationSpeed)
                                    .repeatCount(
                                        animationRepeatCount,
                                        autoreverses:
                                            animationAutoreverses)
                                ) {
                                    showSpacer.toggle()
                                }
                            case .type3:
                                withAnimation(
                                    .spring(
                                        response: springAnimationResponse,
                                        dampingFraction:
                                            springAnimationDampingFraction,
                                        blendDuration:
                                            springAnimationBlendDuration
                                    )
                                    .delay(animationDelay)
                                    .speed(animationSpeed)
                                    .repeatCount(
                                        animationRepeatCount,
                                        autoreverses:
                                            animationAutoreverses)
                                ) {
                                    showSpacer.toggle()
                                }
                            }
                        case .linear:
                            withAnimation(
                                .linear(
                                    duration:
                                        animationDuration)
                            ) {
                                showSpacer.toggle()
                            }
                        case .easeIn:
                            withAnimation(
                                .easeIn(
                                    duration:
                                        animationDuration)
                            ) {
                                showSpacer.toggle()
                            }
                        case .easeOut:
                            withAnimation(
                                .easeOut(
                                    duration:
                                        animationDuration)
                            ) {
                                showSpacer.toggle()
                            }
                        case .easeInOut:
                            withAnimation(
                                .easeInOut(
                                    duration:
                                        animationDuration
                                )
                            ) {
                                showSpacer.toggle()
                            }
                        case .bouncy:
                            withAnimation(
                                .bouncy(
                                    duration:
                                        animationDuration,
                                    extraBounce: animationExtraBounce
                                )
                            ) {
                                showSpacer.toggle()
                            }
                        case .smooth:
                            withAnimation(
                                .smooth(
                                    duration:
                                        animationDuration,
                                    extraBounce: animationExtraBounce
                                )
                            ) {
                                showSpacer.toggle()
                            }
                        case .snappy:
                            withAnimation(
                                .snappy(
                                    duration:
                                        animationDuration,
                                    extraBounce: animationExtraBounce
                                )
                            ) {
                                showSpacer.toggle()
                            }
                        case .interactiveSpring:
                            withAnimation(.interactiveSpring) {
                                showSpacer.toggle()
                            }
                        case .custom:
                            withAnimation(.linear(duration: 2)) {
                                showSpacer.toggle()
                            }
                        }
                    }
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
            .navigationTitle("Animations")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .inspector(
                isPresented: $showInspector.animation()
            ) {
                List {
                    Section {
                        Picker(
                            "Animation",
                            selection: $selectedAnimationType.animation()
                        ) {
                            ForEach(AnimationType.allCases, id: \.id) {
                                type in
                                Text(type.name)
                                    .tag(type)
                            }
                        }
                        .onChange(of: selectedAnimationType) { _, newValue in
                            withAnimation {
                                showSpacer = false
                                if newValue == .smooth {
                                    animationDuration = 0.5
                                    animationExtraBounce = 0.0
                                }
                            }
                        }

                        if selectedAnimationType == .spring {
                            Picker("Spring", selection: $selectedSpringType) {
                                ForEach(SpringAnimationType.allCases, id: \.id)
                                {
                                    type in
                                    Text(type.name)
                                        .tag(type)
                                }
                            }
                        }
                    } header: {
                        Text("Type")
                    } footer: {
                        if showDescription {
                            Text(selectedAnimationType.description)
                        }
                    }

                    Section("Control") {
                        CustomStepperWithDescription(
                            value: $animationDelay,
                            showDescription: $showDescription,
                            label: "Delay",
                            range: 0...10,
                            step: 0.5,
                            description:
                                "Delays the start of the animation by the specified number of seconds."
                        )
                        CustomStepperWithDescription(
                            value: $animationSpeed,
                            showDescription: $showDescription,
                            label: "Speed",
                            range: 0...5,
                            step: 0.1,
                            description:
                                "Changes the duration of an animation by adjusting its speed."
                        )
                        WithDescriptionView(
                            showDescription: $showDescription,
                            description:
                                "The number of times that the animation repeats. Each repeated sequence starts at the beginning when autoreverse is false."
                        ) {
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
                        }
                        WithDescriptionView(
                            showDescription: $showDescription,
                            description:
                                "A Boolean value that indicates whether the animation sequence plays in reverse after playing forward. Autoreverse counts towards the repeatCount. For instance, a repeatCount of one plays the animation forward once, but it doesn’t play in reverse even if autoreverse is true. When autoreverse is true and repeatCount is 2, the animation moves forward, then reverses, then stops."
                        ) {
                            Toggle("Autoreverses", isOn: $animationAutoreverses)
                        }

                        if selectedAnimationType != .default {
                            CustomStepperWithDescription(
                                value: $animationDuration,
                                showDescription: $showDescription,
                                label: "Duration",
                                range: 0...10,
                                step: 0.5,
                                description:
                                    "The perceptual duration, which defines the pace of the spring. This is approximately equal to the settling duration, but for very bouncy springs, will be the duration of the period of oscillation for the spring."
                            )
                        }

                        if selectedAnimationType != .linear
                            && selectedAnimationType != .easeIn
                            && selectedAnimationType != .easeInOut
                            && selectedAnimationType != .easeOut
                        {
                            CustomStepperWithDescription(
                                value: $animationExtraBounce,
                                showDescription: $showDescription,
                                label: "ExtraBounce",
                                range: 0...2,
                                step: 0.1,
                                description: selectedAnimationType == .bouncy
                                    ? "How much additional bounce should be added to the base bounce of 0.3."
                                    : selectedAnimationType == .smooth
                                        ? "How much additional bounce should be added to the base bounce of 0."
                                        : "How much additional bounce should be added to the base bounce of 0.15."
                            )
                        }

                        if selectedAnimationType == .spring {
                            if selectedSpringType == .type2 {
                                CustomStepperWithDescription(
                                    value: $springAnimationBounce,
                                    showDescription: $showDescription,
                                    label: "Bounce",
                                    range: -1...1,
                                    step: 0.1,
                                    description:
                                        "How bouncy the spring should be. A value of 0 indicates no bounces (a critically damped spring), positive values indicate increasing amounts of bounciness up to a maximum of 1.0 (corresponding to undamped oscillation), and negative values indicate overdamped springs with a minimum value of -1.0."
                                )
                            }
                            if selectedSpringType == .type3 {
                                CustomStepperWithDescription(
                                    value: $springAnimationResponse,
                                    showDescription: $showDescription,
                                    label: "Response",
                                    range: 0...1,
                                    step: 0.1,
                                    description:
                                        "The stiffness of the spring, defined as an approximate duration in seconds. A value of zero requests an infinitely-stiff spring, suitable for driving interactive animations."
                                )
                                CustomStepperWithDescription(
                                    value: $springAnimationDampingFraction,
                                    showDescription: $showDescription,
                                    label: "DampingFraction",
                                    range: 0...1,
                                    step: 0.005,
                                    description:
                                        "The amount of drag applied to the value being animated, as a fraction of an estimate of amount needed to produce critical damping."
                                )
                            }
                            CustomStepperWithDescription(
                                value: $springAnimationBlendDuration,
                                showDescription: $showDescription,
                                label: "BlendDuration",
                                range: 0...10,
                                step: 1,
                                description:
                                    "The duration in seconds over which to interpolate changes to the response value of the spring."
                            )
                        }
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
    AnimationsView()
}
