//
//  LayoutFundamentalsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/2/2.
//
//

import SwiftUI

enum EVerticalAlignment: String, CaseIterable, Identifiable {
    case top
    case center
    case bottom
    case firstTextBaseline
    case lastTextBaseline

    var id: Self { self }

    var name: String {
        switch self {
        case .top:
            ".top"
        case .center:
            ".center"
        case .bottom:
            ".bottom"
        case .firstTextBaseline:
            ".firstTextBaseline"
        case .lastTextBaseline:
            ".lastTextBaseline"
        }
    }

    var alignment: VerticalAlignment {
        switch self {
        case .top:
            .top
        case .center:
            .center
        case .bottom:
            .bottom
        case .firstTextBaseline:
            .firstTextBaseline
        case .lastTextBaseline:
            .lastTextBaseline
        }
    }
}

enum EHorizontalAlignment: String, CaseIterable, Identifiable {
    case leading
    case center
    case trailing

    var id: Self { self }

    var name: String {
        switch self {
        case .leading:
            ".leading"
        case .center:
            ".center"
        case .trailing:
            ".trailing"
        }
    }

    var alignment: HorizontalAlignment {
        switch self {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }
}

enum EZStackAlignment: String, CaseIterable, Identifiable {

    case topLeading
    case top
    case topTrailing
    case leading
    case center
    case trailing
    case bottomLeading
    case bottom
    case bottomTrailing
    case leadingLastTextBaseline
    case trailingFirstTextBaseline

    var id: Self { self }

    var name: String {
        switch self {
        case .topLeading:
            ".topLeading"
        case .top:
            ".top"
        case .topTrailing:
            ".topTrailing"
        case .leading:
            ".leading"
        case .center:
            ".center"
        case .trailing:
            ".trailing"
        case .bottomLeading:
            ".bottomLeading"
        case .bottom:
            ".bottom"
        case .bottomTrailing:
            ".bottomTrailing"
        case .leadingLastTextBaseline:
            ".leadingLastTextBaseline"
        case .trailingFirstTextBaseline:
            ".trailingFirstTextBaseline"
        }
    }

    var alignment: Alignment {
        switch self {
        case .topLeading:
            .topLeading
        case .top:
            .top
        case .topTrailing:
            .topTrailing
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        case .bottomLeading:
            .bottomLeading
        case .bottom:
            .bottom
        case .bottomTrailing:
            .bottomTrailing
        case .leadingLastTextBaseline:
            .leadingLastTextBaseline
        case .trailingFirstTextBaseline:
            .leadingFirstTextBaseline
        }
    }
}

struct LayoutFundamentalsView: View {
    @Environment(\.openURL) private var openURL

    @State private var showDescription: Bool = true
    @State private var hideTabBar: Bool = false
    @State private var showInspector: Bool = false
    @State private var textLabel: Bool = false
    @State private var size: CGSize = .zero
    @State private var selectedContainerType: LayoutFundamentalsType = .zStack
    @State private var selectedVerticalAlignment: EVerticalAlignment = .top
    @State private var selectedHorizontalAlignment: EHorizontalAlignment =
        .leading
    @State private var selectedZStackAlignment: EZStackAlignment = .center

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                Form {
                    Section("Preview") {
                        CardContainerView {
                            switch selectedContainerType {
                            case .hStack:
                                HStack(
                                    alignment: selectedVerticalAlignment
                                        .alignment
                                ) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.red)
                                        .frame(height: size.width / 7)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.blue)
                                        .frame(height: size.width / 5)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.green)
                                        .frame(height: size.width / 3)
                                }
                            case .vStack:
                                VStack(
                                    alignment: selectedHorizontalAlignment
                                        .alignment
                                ) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.red)
                                        .frame(height: size.height / 12)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.blue)
                                        .frame(
                                            width: size.width / 2,
                                            height: size.height / 12)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.green)
                                        .frame(
                                            width: size.width / 4,
                                            height: size.height / 12)
                                }
                            case .zStack:
                                ZStack(alignment: selectedZStackAlignment.alignment) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.green)
                                        .frame(height: size.height / 5)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.blue)
                                        .frame(
                                            width: size.height / 4,
                                            height: size.height / 8)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.red)
                                        .frame(
                                            width: size.height / 8,
                                            height: size.height / 12)
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
                    }
                    .clearSectionStyle()
                    .task {
                        size = proxy.size
                    }
                }
            }
            .navigationTitle("Layout fundamentals")
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
            .inspector(isPresented: $showInspector) {
                Form {
                    Section {
                        Picker(
                            "Type",
                            selection: $selectedContainerType.animation()
                        ) {
                            ForEach(LayoutFundamentalsType.allCases) { type in
                                Text(type.name)
                            }
                        }
                    } footer: {
                        if showDescription {
                            Text(selectedContainerType.description)
                        }
                    }

                    Section {
                        switch selectedContainerType {
                        case .hStack:
                            PickerContainer(
                                "alignment",
                                selection: $selectedVerticalAlignment
                            ) { alginment in
                                Text(alginment.name)
                            }
                        case .vStack:
                            PickerContainer(
                                "alignment",
                                selection: $selectedHorizontalAlignment
                            ) { alginment in
                                Text(alginment.name)
                            }
                        case .zStack:
                            PickerContainer(
                                "alignment",
                                selection: $selectedZStackAlignment
                            ) { alginment in
                                Text(alginment.name)
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
                }
            }
        }
    }
}

#Preview {
    LayoutFundamentalsView()
}
