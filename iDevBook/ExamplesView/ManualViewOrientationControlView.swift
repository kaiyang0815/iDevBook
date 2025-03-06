//
// ManualViewOrientationControlView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

enum Orientation: String, CaseIterable {
    case all = "All"
    case portrait = "Portrait"
    case landscapeLeft = "Left"
    case landscapeRight = "Right"

    var mask: UIInterfaceOrientationMask {
        switch self {
        case .all:
            return .all
        case .portrait:
            return .portrait
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        }
    }
}

struct ManualViewOrientationControlView: View {
    @State private var selectedOrientation: Orientation = .portrait
    var body: some View {
        NavigationStack {
            List {
                Section("Orientation") {
                    Picker("", selection: $selectedOrientation) {
                        ForEach(Orientation.allCases, id: \.rawValue) {
                            orientation in
                            Text(orientation.rawValue)
                                .tag(orientation)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .onChange(of: selectedOrientation, initial: true) { oldValue, newValue in
                        modifyOrientation(newValue.mask)
                    }
                }
            }
        }
    }
}

#Preview {
    ManualViewOrientationControlView()
}

extension View {
    func modifyOrientation(_ mask: UIInterfaceOrientationMask) {
        if let windowScene =
            (UIApplication.shared.connectedScenes.first as? UIWindowScene)
        {
            // limit auto rotation
            AppDelegate.orientation = mask
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: mask))
            windowScene.keyWindow?.rootViewController?
                .setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}
