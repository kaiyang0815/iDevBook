//
// WillDisappearHandler.swift
// iDevBook
//
// Raw code from https://stackoverflow.com/questions/59745663/is-there-a-swiftui-equivalent-for-viewwilldisappear-or-detect-when-a-view-is
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

#if os(iOS)
    struct WillDisappearHandler: UIViewControllerRepresentable {
        func makeCoordinator() -> WillDisappearHandler.Coordinator {
            Coordinator(onWillDisappear: onWillDisappear)
        }

        let onWillDisappear: () -> Void

        func makeUIViewController(
            context: UIViewControllerRepresentableContext<WillDisappearHandler>
        ) -> UIViewController {
            context.coordinator
        }

        func updateUIViewController(
            _ uiViewController: UIViewController,
            context: UIViewControllerRepresentableContext<WillDisappearHandler>
        ) {
        }

        typealias UIViewControllerType = UIViewController

        class Coordinator: UIViewController {
            let onWillDisappear: () -> Void

            init(onWillDisappear: @escaping () -> Void) {
                self.onWillDisappear = onWillDisappear
                super.init(nibName: nil, bundle: nil)
            }

            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }

            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                onWillDisappear()
            }
        }
    }

    struct WillDisappearModifier: ViewModifier {
        let callback: () -> Void

        func body(content: Content) -> some View {
            content
                .background(WillDisappearHandler(onWillDisappear: callback))
        }
    }

    extension View {
        func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
            self.modifier(WillDisappearModifier(callback: perform))
        }
    }
#endif
