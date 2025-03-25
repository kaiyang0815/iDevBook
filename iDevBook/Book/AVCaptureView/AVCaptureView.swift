//
// AVCaptureView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import AVFoundation
import Combine
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {
        uiView.videoPreviewLayer.frame = uiView.bounds
    }

    class PreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }

        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            layer as! AVCaptureVideoPreviewLayer
        }
    }
}

@Observable
final class CameraManager {
    var session = AVCaptureSession()

    var status: Status = .unconfigured

    enum Status {
        case unconfigured, configured, unauthorized, failed
    }

    func configureCaptureSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        guard
            let camera = AVCaptureDevice.default(
                .builtInWideAngleCamera, for: .video, position: .back),
            let videoInput = try? AVCaptureDeviceInput(device: camera),
            session.canAddInput(videoInput)
        else {
            status = .failed
            session.commitConfiguration()
            return
        }
        session.addInput(videoInput)
        session.commitConfiguration()
        status = .configured
    }

    func startSession() {
        guard status == .configured, !session.isRunning else {
            print("not configured or already running")
            return
        }
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
    }

    func stopSession() {
        if session.isRunning {
            DispatchQueue.global(qos: .background).async {
                self.session.stopRunning()
            }
        }
    }
}

struct AVCaptureView: View {
    @State private var hideTabBar: Bool = false
    @State private var showDescription: Bool = false
    @State private var showInspector: Bool = true
    @State private var size: CGSize = .zero

    @State private var cameraManager = CameraManager()

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        CardContainerView {
                            CameraPreview(session: cameraManager.session)
                                .frame(height: size.height / 4)
                        }
                    }
                    .clearSectionStyle()
                }
                .task {
                    size = proxy.size
                    cameraManager.configureCaptureSession()
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
                                cameraManager.startSession()
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
