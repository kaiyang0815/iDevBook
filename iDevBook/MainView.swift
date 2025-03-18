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
            Form {
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
                        DrawingandGraphicsView()
                    } label: {
                        Text("Drawing and graphics")
                    }
                }
                
                Section("App Intents") {
                    
                }
                
                Section("AVFoundation") {
                    NavigationLink {
                        AVCaptureView()
                    } label: {
                        Text("Capture")
                    }
                }

                Section("SF Symbols") {
                    NavigationLink {
                        SFSymbolsView()
                    } label: {
                        Text("SF Symbols Picker")
                    }
                }

                Section("Packages") {
                    NavigationLink {
                        RichTextKitDemoView()
                    } label: {
                        Text("RichTextKit")
                    }

                    #if os(iOS)
                        NavigationLink {
//                            LexicalDemoView()
                        } label: {
                            Text("lexical-ios")
                        }
                    #endif

                    NavigationLink {
                        HighlightSwiftView()
                    } label: {
                        Text("HighlightSwift")
                    }
                    
                    NavigationLink {
                        EFQRCodeView()
                    } label: {
                        Text("EFQRCode")
                    }

                }

                #if os(iOS)
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
                #endif

                Section("Other") {
                    NavigationLink {
                        BookmarkView()
                    } label: {
                        Text("Bookmark")
                    }
                }
            }
            .navigationTitle("iDev Book")
            .formStyle(.grouped)
            #if os(iOS)
                .toolbarRole(.editor)
            #endif
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: LocalFeed.self)
}
