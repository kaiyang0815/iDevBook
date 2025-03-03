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
                Section("Views") {
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
                }

                Section("Examples") {
                    NavigationLink {
                        AppShortcutsDemoView()
                    } label: {
                        Text("App Shortcuts")
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
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    MainView()
}
