//
//  MainView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/29.
//
//

import SwiftUI

struct MainView: View {
    @State private var searchText: String = ""
    @State private var hideTabBar: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                Section("Latest") {
                    NavigationLink {
                        SwiftLanguage6View()
                    } label: {
                        Text("Swift 6")
                    }
                }
                Section("SwiftUI") {
                    NavigationLink {
                        AnimationsView()
                    } label: {
                        Text("Animations")
                    }
                    NavigationLink {
                        TextInputAndOutputView()
                    } label: {
                        Text("Text input and output")
                    }
                    NavigationLink {
                        ImagesView()
                    } label: {
                        Text("Images")
                    }
                    NavigationLink {
                        ControlsAndIndicatorsView()
                    } label: {
                        Text("Controls and indicators")
                    }
                    NavigationLink {
                        ShapesView()
                    } label: {
                        Text("Shapes")
                    }
                    NavigationLink {
                        GesturesView()
                    } label: {
                        Text("Gestures")
                    }
                }

                Section("View layout") {
                    Text("Layout fundamentals")
                }

                Section("Packages") {
                    NavigationLink {
                        RichTextKitDemoView()
                    } label: {
                        Text("RichTextKit")
                    }

                    NavigationLink {
                        LexicalDemoView()
                    } label: {
                        Text("lexical-ios")
                    }

                    NavigationLink {
                        HighlightSwiftView()
                    } label: {
                        Text("HighlightSwift")
                    }
                }

                Section("Examples") {
                    NavigationLink {
                        AppShortcutsDemoView()
                    } label: {
                        Text("App Shortcuts")
                    }
                    NavigationLink {
                        ManualViewOrientationControlView()
                    } label: {
                        Text("Manual View Orientation Control")
                    }
                }

                Section("Other") {
                    NavigationLink {
                        BookmarkView()
                    } label: {
                        Text("Bookmark")
                    }
                }
            }
            .navigationTitle("iDev Book")
            .toolbarVisibility(hideTabBar ? .hidden : .automatic, for: .tabBar)
            .onAppear {
                withAnimation {
                    hideTabBar = false
                }
            }
            #if os(iOS)
                .toolbarRole(.editor)
            #endif
        }
    }
}

#Preview {
    RootView()
}
