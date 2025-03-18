//
//  MenusAndCommandsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/18.
//
//

import SwiftUI

enum MenusAndCommandsType: String, CaseIterable, Identifiable {
    case menu
    case contextMenu
    case command

    var id: Self { self }

    var name: String {
        switch self {
        case .menu:
            "Menu"
        case .contextMenu:
            "contextMenu"
        case .command:
            "Command"
        }
    }

    var description: String {
        switch self {
        case .menu:
            ""
        case .contextMenu:
            ""
        case .command:
            ""
        }
    }
}

struct MenusAndCommandsView: View {
    @State private var hideTabBar: Bool = false
    @State private var showInspector: Bool = false
    @State private var textLabel: Bool = false

    @State private var selectedMACType: MenusAndCommandsType = .contextMenu

    var body: some View {
        NavigationStack {
            Form {
                Section("Preview") {
                    CardContainerView {
                        switch selectedMACType {
                        case .menu:
                            Menu {
                                Button {

                                } label: {
                                    Text("Open in Preview")
                                    Text("View the document in Preview")
                                }
                                Button {

                                } label: {
                                    Text("Save as PDF")
                                    Text("Export the document as a PDF file")
                                }
                            } label: {
                                if textLabel {
                                    Text("Menu")
                                } else {
                                    Label("PDF", systemImage: "doc.fill")
                                }
                            }
                        case .contextMenu:
                            Text("SwiftUI")
                                .contextMenu {
                                    Button {
                                        // Add this item to a list of favorites.
                                    } label: {
                                        Label(
                                            "Add to Favorites",
                                            systemImage: "heart")
                                    }
                                    Button {
                                        // Open Maps and center it on this item.
                                    } label: {
                                        Label(
                                            "Show in Maps",
                                            systemImage: "mappin")
                                    }
                                } preview: {
                                    Image("SwiftUI")  // Loads the image from an asset catalog.
                                }
                        case .command:
                            #if os(iOS)
                                Text("macOS only")
                            #else
                                Text("See menu bar")
                            #endif
                        }
                    }
                }
                .clearSectionStyle()
            }
            .navigationTitle("Menus and commands")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .onAppear {
                withAnimation {
                    hideTabBar.toggle()
                    showInspector = true
                }
            }
            .onWillDisappear {
                withAnimation {
                    showInspector = false
                }
            }
            .inspector(isPresented: $showInspector) {
                Form {
                    Section("Control") {
                        PickerContainer("Type", selection: $selectedMACType) {
                            type in
                            Text(type.name)
                                #if os(iOS)
                                    .selectionDisabled(type == .command)
                                #endif
                        }
                    }
                    Toggle(isOn: $textLabel) {
                        Text("label")
                    }
                }
            }
        }
    }
}

#Preview {
    MenusAndCommandsView()
}
