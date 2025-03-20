//
// AVCaptureView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

struct AVCaptureView: View {
    @State private var hideTabBar: Bool = false
    @State private var showDescription: Bool = false
    @State private var showInspector: Bool = true
    @State private var size: CGSize = .zero

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        CardContainerView {
                            
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
            .navigationTitle("AVCaptureView")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .inspector(isPresented: $showInspector) {
                Form {
                    Section("Control") {
                        Button {
                            Task {
                                
                            }
                        } label: {
                            Label("Start", systemImage: "play")
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
    AVCaptureView()
}
