//
// EFQRCodeView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import EFQRCode
import PhotosUI
import SwiftUI

struct EFQRCodeView: View {
    @State private var showInspector: Bool = true
    @State private var showDescription: Bool = true
    @State private var hideTabBar: Bool = false

    @State private var codeSize: CGSize = .init(width: 600, height: 600)
    @State private var codeContent: String =
        "https://developer.apple.com/xcode/swiftui/"
    @State private var codeWartermark: CGImage? = UIImage(named: "SwiftUI")?
        .cgImage
    @State private var codeIcon: CGImage? = UIImage(named: "SwiftUI")?
        .cgImage
    @State private var codeIconSize: CGSize = .init(width: 64, height: 64)
    @State private var codeForegroundColor: CGColor = CGColor.black()!
    @State private var codeBackgroundColor: CGColor = CGColor.white()!
    @State private var codeInputCorrectionLevel: EFInputCorrectionLevel = .h
    @State private var codeMode: EFQRCodeMode? = nil

    @State private var size: CGSize = .zero
    @State private var watermarkItem: PhotosPickerItem?
    @State private var iconItem: PhotosPickerItem?

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        CardContainerView {
                            if let image = EFQRCode.generate(
                                for: codeContent,
                                inputCorrectionLevel: codeInputCorrectionLevel,
                                size: EFIntSize(size: codeSize),
                                backgroundColor: codeBackgroundColor,
                                foregroundColor: codeForegroundColor,
                                watermark: codeWartermark,
                                icon: codeIcon,
                                iconSize: EFIntSize(size: codeIconSize),
                                mode: codeMode
                            ) {
                                Image(
                                    image,
                                    scale: 1.0,
                                    orientation: .up,
                                    label: Text(codeContent)
                                )
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: size.height / 4)
                            }
                        }
                    }
                    .clearSectionStyle()
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
            .navigationTitle("EFQRCode")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .inspector(isPresented: $showInspector) {
                List {
                    Section("Control") {
                        ClearableTextField("content", text: $codeContent)
                        ColorPicker(
                            "foregroundColor", selection: $codeForegroundColor)
                        ColorPicker(
                            "backgroundColor", selection: $codeBackgroundColor)
                        LabeledContent {
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.ultraThickMaterial)
                                Image(
                                    codeWartermark!,
                                    scale: 1.0,
                                    orientation: .up,
                                    label: Text("watermark")
                                )
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            }
                            .frame(width: 28, height: 28)
                            .clipShape(.rect(cornerRadius: 4))
                        } label: {
                            PhotosPicker(
                                "watermark", selection: $watermarkItem,
                                matching: .images)
                        }

                        LabeledContent {
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.ultraThickMaterial)
                                Image(
                                    codeIcon!,
                                    scale: 1.0,
                                    orientation: .up,
                                    label: Text("watermark")
                                )
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            }
                            .frame(width: 28, height: 28)
                            .clipShape(.rect(cornerRadius: 4))
                        } label: {
                            PhotosPicker(
                                "icon", selection: $iconItem,
                                matching: .images)
                        }
                        LabeledContent {
                            Slider(value: $codeIconSize.width, in: 0...200) {
                                Text("iconSize")
                            } minimumValueLabel: {
                                Text("0")
                            } maximumValueLabel: {
                                Text("100")
                            }
                        } label: {
                            Text("iconSize.width")
                        }
                        LabeledContent {
                            Slider(value: $codeIconSize.height, in: 0...200) {
                                Text("iconSize")
                            } minimumValueLabel: {
                                Text("0")
                            } maximumValueLabel: {
                                Text("100")
                            }
                        } label: {
                            Text("iconSize.height")
                        }
                    }
                }
                .onChange(of: watermarkItem) {
                    Task {
                        if let loaded = try? await watermarkItem?
                            .loadTransferable(type: Image.self)
                        {
                            codeWartermark =
                                ImageRenderer(content: loaded).cgImage
                        } else {
                            print("Failed")
                        }
                    }
                }
                .onChange(of: iconItem) {
                    Task {
                        if let loaded = try? await iconItem?
                            .loadTransferable(type: Image.self)
                        {
                            codeIcon =
                                ImageRenderer(content: loaded).cgImage
                        } else {
                            print("Failed")
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
                    RepoLink("https://github.com/EFPrefix/EFQRCode")
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
    EFQRCodeView()
}
