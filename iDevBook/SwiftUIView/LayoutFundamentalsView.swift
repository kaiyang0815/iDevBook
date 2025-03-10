//
//  LayoutFundamentalsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/2/2.
//
//

import SwiftUI

enum LayoutFundamentalsType: String, CaseIterable, Identifiable {
    case hStack
    case vStack
    case zStack
    case lazyHStack
    case lazyVStack
    case grid
    case gridRow
    case lazyHGrid
    case lazyVGrid
    case gridItem
    case viewThatFits
    case spacer
    case divider

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .hStack:
            "HStack"
        case .vStack:
            "VStack"
        case .zStack:
            "ZStack"
        case .lazyHStack:
            "LazyHStack"
        case .lazyVStack:
            "LazyVStack"
        case .grid:
            "Grid"
        case .gridRow:
            "GridRow"
        case .lazyHGrid:
            "LazyHGrid"
        case .lazyVGrid:
            "LazyVGrid"
        case .gridItem:
            "GridItem"
        case .viewThatFits:
            "ViewThatFits"
        case .spacer:
            "Spacer"
        case .divider:
            "Divider"
        }
    }

    var description: String {
        switch self {
        case .hStack:
            "A view that arranges its subviews in a horizontal line."
        case .vStack:
            "A view that arranges its subviews in a vertical line."
        case .zStack:
            "A view that overlays its subviews, aligning them in both axes."
        case .lazyHStack:
            "A view that arranges its children in a line that grows horizontally, creating items only as needed."
        case .lazyVStack:
            "A view that arranges its children in a line that grows vertically, creating items only as needed."
        case .grid:
            "A container view that arranges other views in a two dimensional layout."
        case .gridRow:
            "A horizontal row in a two dimensional grid container."
        case .lazyHGrid:
            "A container view that arranges its child views in a grid that grows horizontally, creating items only as needed."
        case .lazyVGrid:
            "A container view that arranges its child views in a grid that grows vertically, creating items only as needed."
        case .gridItem:
            "A description of a row or a column in a lazy grid."
        case .viewThatFits:
            "A view that adapts to the available space by providing the first child view that fits."
        case .spacer:
            "A flexible space that expands along the major axis of its containing stack layout, or on both axes if not contained in a stack."
        case .divider:
            "A visual element that can be used to separate other content."
        }
    }
}

struct LayoutFundamentalsView: View {
    @Environment(\.openURL) private var openURL

    @State private var showDescription: Bool = true
    @State private var selectdContainerType: LayoutFundamentalsType = .hStack

    var body: some View {
        NavigationStack {
            List {
                Section {
                    switch selectdContainerType {
                    case .hStack:
                        HStack {
                            Spacer()
                            HStack(alignment: .center, spacing: 20) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.red)
                                    .frame(width: 40, height: 40)
                                Capsule()
                                    .fill(.blue)
                                    .frame(width: 80, height: 60)
                                Circle()
                                    .fill(.green)
                                    .frame(width: 100, height: 100)
                            }
                            Spacer()
                        }
                    case .vStack:
                        HStack {
                            Spacer()
                            VStack(alignment: .center, spacing: 20) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.red)
                                    .frame(width: 40, height: 40)
                                Capsule()
                                    .fill(.blue)
                                    .frame(width: 80, height: 60)
                                Circle()
                                    .fill(.green)
                                    .frame(width: 100, height: 100)
                            }
                            Spacer()
                        }
                    case .zStack:
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 100, height: 100)
                                Capsule()
                                    .fill(.blue)
                                    .frame(width: 80, height: 50)
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.red)
                                    .frame(width: 40, height: 40)
                            }
                            Spacer()
                        }
                    case .lazyHStack:
                        Text("")
                    case .lazyVStack:
                        Text("")
                    case .grid:
                        Text("")
                    case .gridRow:
                        Text("")
                    case .lazyHGrid:
                        Text("")
                    case .lazyVGrid:
                        Text("")
                    case .gridItem:
                        Text("")
                    case .viewThatFits:
                        Text("")
                    case .spacer:
                        Text("")
                    case .divider:
                        Text("")
                    }
                }
                Section {
                    Picker("Type", selection: $selectdContainerType.animation()) {
                        ForEach(LayoutFundamentalsType.allCases) { type in
                            Text(type.name)
                        }
                    }
                } footer: {
                    if showDescription {
                        Text(selectdContainerType.description)
                    }
                }
            }
            .navigationTitle("Layout fundamentals")
            .toolbar {
                Menu {
                    Button {
                        if let url = URL(
                            string:
                                "https://developer.apple.com/design/Human-Interface-Guidelines/layout"
                        ) {
                            openURL(url)
                        }
                    } label: {
                        Label(
                            "Human Interface Guidelines",
                            systemImage: "book.pages")
                    }
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
            }
        }
    }
}

#Preview {
    LayoutFundamentalsView()
}
