//
// SymbolInspectorView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum ESymbolRenderingMode: String, CaseIterable, Identifiable {
    case monochrome
    case hierarchical
    case palette
    case multicolor

    var name: String {
        switch self {
        case .monochrome:
            "Monochrome"
        case .hierarchical:
            "Hierarchical"
        case .palette:
            "Paltette"
        case .multicolor:
            "Multicolor"
        }
    }

    var id: Self {
        return self
    }

    var mode: SymbolRenderingMode {
        switch self {
        case .monochrome:
            .monochrome
        case .hierarchical:
            .hierarchical
        case .palette:
            .palette
        case .multicolor:
            .multicolor
        }
    }
}

enum ESymbolEffect: String, CaseIterable, Identifiable {
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
            "scale"
        case .variableColor:
            "Variable Color"
        case .breathe:
            "Breathe"
        case .rotate:
            "Rotate"
        case .wiggle:
            "Wiggle"
        }
    }
}

enum SFSymbolInspectorTab: String, CaseIterable, Identifiable {
    case info
    case rendering
    case animation

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .info:
            "Info"
        case .rendering:
            "Rendering"
        case .animation:
            "Animation"
        }
    }

    var symbol: String {
        switch self {
        case .info:
            "info.circle"
        case .rendering:
            "paintbrush"
        case .animation:
            "play"
        }
    }
}

struct SymbolInspectorView: View {
    @Binding var symbol: String
    @State private var renderingMode: ESymbolRenderingMode = .monochrome
    @State private var selectedSymbolEffect: ESymbolEffect = .bounce
    @State private var selectedTab: SFSymbolInspectorTab = .info

    @State private var isActive = false
    @State private var isPresented = false
    @State private var foregroundColor: Color = .primary
#if os(iOS)
    @State private var backgroundColor: Color = Color(
        uiColor: UIColor.secondarySystemGroupedBackground)
#endif

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        switch selectedSymbolEffect {
                        case .appear:
                            if isPresented {
                                Image(systemName: symbol)
                                    .symbolRenderingMode(renderingMode.mode)
                                    .transition(.symbolEffect(.appear))
                                    .foregroundStyle(foregroundColor)
                                    .font(.system(size: 80))
                                    .frame(
                                        maxWidth: .infinity, alignment: .center)
                            }
                        case .bounce:
                            Image(systemName: symbol)
                                .symbolRenderingMode(renderingMode.mode)
                                .symbolEffect(
                                    .bounce.down.byLayer, value: isActive
                                )
                                .foregroundStyle(foregroundColor)
                                .font(.system(size: 80))
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .disappear:
                            if isPresented {
                                Image(systemName: symbol)
                                    .symbolRenderingMode(renderingMode.mode)
                                    .transition(.symbolEffect(.disappear))
                                    .foregroundStyle(foregroundColor)
                                    .font(.system(size: 80))
                                    .frame(
                                        maxWidth: .infinity, alignment: .center)
                            }
                        case .pulse:
                            Image(systemName: symbol)
                                .symbolRenderingMode(renderingMode.mode)
                                .symbolEffect(.pulse, value: isActive)
                                .foregroundStyle(foregroundColor)
                                .font(.system(size: 80))
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .scale:
                            Image(systemName: symbol)
                                .symbolRenderingMode(renderingMode.mode)
                                //                                .symbolEffect(.scale, value: isActive)
                                .foregroundStyle(foregroundColor)
                                .font(.system(size: 80))
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .variableColor:
                            Image(systemName: symbol)
                                .symbolRenderingMode(renderingMode.mode)
                                .symbolEffect(.variableColor, value: isActive)
                                .foregroundStyle(foregroundColor)
                                .font(.system(size: 80))
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .breathe:
                            Image(systemName: symbol)
                                .symbolRenderingMode(renderingMode.mode)
                                .symbolEffect(.breathe, value: isActive)
                                .foregroundStyle(foregroundColor)
                                .font(.system(size: 80))
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .rotate:
                            Image(systemName: symbol)
                                .symbolRenderingMode(renderingMode.mode)
                                .symbolEffect(.rotate, value: isActive)
                                .foregroundStyle(foregroundColor)
                                .font(.system(size: 80))
                                .frame(maxWidth: .infinity, alignment: .center)
                        case .wiggle:
                            Image(systemName: symbol)
                                .symbolRenderingMode(renderingMode.mode)
                                .symbolEffect(.wiggle, value: isActive)
                                .foregroundStyle(foregroundColor)
                                .font(.system(size: 80))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .frame(minHeight: 120)
                } header: {
                    Text("Inspector")
                } footer: {
                    Text(symbol)
                }
#if os(iOS)
                .listRowBackground(backgroundColor)
                #endif

                Section("Control") {
                    Picker("Mode", selection: $selectedTab) {
                        ForEach(SFSymbolInspectorTab.allCases) { tab in
                            Text(tab.name)
                        }
                    }
                    .pickerStyle(.segmented)

                    switch selectedTab {
                    case .info:
                        Text(symbol)
                    case .rendering:
                        Picker("Rendering", selection: $renderingMode) {
                            ForEach(ESymbolRenderingMode.allCases) { mode in
                                Text(mode.name)
                                    .tag(mode)
                            }
                        }
                        ColorPicker("Color", selection: $foregroundColor)
                        #if os(iOS)
                        ColorPicker("Background", selection: $backgroundColor)
                        #endif
                    case .animation:
                        Picker("Animation", selection: $selectedSymbolEffect) {
                            ForEach(ESymbolEffect.allCases) { effect in
                                Text(effect.name)
                            }
                        }
                        Button {
                            withAnimation {
                                isPresented.toggle()
                                isActive.toggle()
                            }
                        } label: {
                            Label("Preview", systemImage: "play.fill")
                        }
                    }
                }
                .onChange(of: selectedSymbolEffect) { oldValue, newValue in
                    if newValue == .disappear {
                        isPresented = true
                    }
                    if newValue == .appear {
                        isPresented = false
                    }
                }
            }
            .navigationTitle("Inspector")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}

#Preview {
    SymbolInspectorView(
        symbol: .constant(
            "airpodspro.chargingcase.wireless.radiowaves.left.and.right.fill"))
}
