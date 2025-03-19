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

enum DividerOrientation: String, CaseIterable, Identifiable {
    case horizontal
    case vertical

    var id: Self { self }

    var name: String {
        switch self {
        case .horizontal:
            "Horizontal"
        case .vertical:
            "Vertical"
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
    @State private var selectedContainerType: LayoutFundamentalsType =
        .grid
    @State private var selectedVerticalAlignment: EVerticalAlignment = .top
    @State private var selectedHorizontalAlignment: EHorizontalAlignment =
        .leading
    @State private var selectedZStackAlignment: EZStackAlignment = .center

    @State private var currentSpacing: CGFloat = 10
    @State private var showScrollIndicators: Bool = false

    @State private var selectedDividerOrientation: DividerOrientation =
        .horizontal

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
                                        .alignment,
                                    spacing: currentSpacing
                                ) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.red.gradient)
                                        .frame(height: size.width / 7)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.blue.gradient)
                                        .frame(height: size.width / 5)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.green.gradient)
                                        .frame(height: size.width / 3)
                                }
                            case .vStack:
                                VStack(
                                    alignment: selectedHorizontalAlignment
                                        .alignment,
                                    spacing: currentSpacing
                                ) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.red.gradient)
                                        .frame(height: size.height / 12)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.blue.gradient)
                                        .frame(
                                            width: size.width / 2,
                                            height: size.height / 12)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.green.gradient)
                                        .frame(
                                            width: size.width / 4,
                                            height: size.height / 12)
                                }
                            case .zStack:
                                ZStack(
                                    alignment: selectedZStackAlignment.alignment
                                ) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.green.gradient)
                                        .frame(height: size.height / 5)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.blue.gradient)
                                        .frame(
                                            width: size.height / 4,
                                            height: size.height / 8)
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.red.gradient)
                                        .frame(
                                            width: size.height / 8,
                                            height: size.height / 12)
                                }
                            case .lazyHStack:
                                ScrollView(.horizontal) {
                                    LazyHStack(
                                        alignment: selectedVerticalAlignment
                                            .alignment,
                                        spacing: currentSpacing
                                    ) {
                                        ForEach(0..<10) { i in
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(.green.gradient)
                                                .frame(
                                                    width: size.width / 2,
                                                    height: size.height / 10)
                                        }
                                    }
                                    .scrollTargetLayout()
                                }
                                .scrollTargetBehavior(.viewAligned)
                                .scrollIndicators(
                                    showScrollIndicators ? .automatic : .hidden)
                            case .lazyVStack:
                                ScrollView {
                                    LazyVStack(
                                        alignment: selectedHorizontalAlignment
                                            .alignment, spacing: currentSpacing
                                    ) {
                                        ForEach(1...10, id: \.self) { i in
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(.green.gradient)
                                                .frame(height: size.height / 10)
                                        }
                                    }
                                }
                                .frame(height: size.height / 4)
                                .scrollIndicators(
                                    showScrollIndicators ? .automatic : .hidden)
                            case .grid:
                                Grid(
                                    alignment: .topLeading,
                                    horizontalSpacing: 1,
                                    verticalSpacing: 30
                                ) {
                                    GridRow {
                                        Color.clear
                                            .gridCellUnsizedAxes([
                                                .horizontal, .vertical,
                                            ])
                                        ForEach(0..<3) { _ in
                                            Color.pink.frame(
                                                width: 50, height: 50)
                                        }
                                    }
                                    GridRow {
                                        Color.yellow.frame(
                                            width: 50, height: 50)
                                        Color.clear
                                            .gridCellUnsizedAxes([
                                                .horizontal, .vertical,
                                            ])
                                        Color.yellow.frame(
                                            width: 25, height: 25)
                                        Color.clear
                                            .gridCellUnsizedAxes([
                                                .horizontal, .vertical,
                                            ])
                                        Color.yellow.frame(
                                            width: 50, height: 50)
                                    }
                                    GridRow {
                                        ForEach(0..<5) { _ in
                                            Color.mint.frame(
                                                width: 50, height: 50)
                                        }
                                    }
                                }
                            case .lazyHGrid:
                                ScrollView(.horizontal) {
                                    LazyHGrid(
                                        rows: [
                                            GridItem(.fixed(50)),
                                            GridItem(.fixed(50)),
                                        ], alignment: .center
                                    ) {
                                        ForEach(1...50, id: \.self) { item in
                                            Image(
                                                systemName:
                                                    "\(item).circle.fill"
                                            )
                                            .font(.largeTitle)
                                        }
                                    }
                                    .frame(height: 150)
                                }
                            case .lazyVGrid:
                                ScrollView {
                                    LazyVGrid(columns: [
                                        GridItem(.adaptive(minimum: 80))
                                    ], spacing: 20) {
                                        ForEach(1...50, id: \.self) { item in
                                            Image(
                                                systemName:
                                                    "\(item).circle.fill"
                                            )
                                            .font(.largeTitle)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            case .viewThatFits:
                                Text("")
                            case .spacer:
                                Spacer(minLength: 40)
                                    .background {
                                        Color.gray
                                    }
                            case .divider:
                                switch selectedDividerOrientation {
                                case .horizontal:
                                    VStack {
                                        Spacer()
                                        Divider()
                                            .frame(
                                                width: size.width * 0.6,
                                                height: 4
                                            )
                                            .overlay(.red)
                                        Spacer()
                                    }
                                case .vertical:
                                    HStack {
                                        Spacer()
                                        Divider()
                                            .frame(
                                                width: 4,
                                                height: size.height / 5
                                            )
                                            .overlay(.red)
                                        Spacer()
                                    }
                                }
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
                            PickerContainer(
                                "alignment",
                                selection: $selectedVerticalAlignment
                            ) { alginment in
                                Text(alginment.name)
                            }
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "Sets the visibility of scroll indicators within this view."
                            ) {
                                Toggle(isOn: $showScrollIndicators) {
                                    Text("scrollIndicators")
                                }
                            }
                        case .lazyVStack:
                            PickerContainer(
                                "alignment",
                                selection: $selectedHorizontalAlignment
                            ) { alginment in
                                Text(alginment.name)
                            }
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "Sets the visibility of scroll indicators within this view."
                            ) {
                                Toggle(isOn: $showScrollIndicators) {
                                    Text("scrollIndicators")
                                }
                            }
                        case .grid:
                            Text("")
                        case .lazyHGrid:
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "Sets the visibility of scroll indicators within this view."
                            ) {
                                Toggle(isOn: $showScrollIndicators) {
                                    Text("scrollIndicators")
                                }
                            }
                        case .lazyVGrid:
                            WithDescriptionView(
                                showDescription: $showDescription,
                                description:
                                    "Sets the visibility of scroll indicators within this view."
                            ) {
                                Toggle(isOn: $showScrollIndicators) {
                                    Text("scrollIndicators")
                                }
                            }
                        case .viewThatFits:
                            Text("")
                        case .spacer:
                            Text("")
                        case .divider:
                            PickerContainer(
                                "Orientation",
                                selection: $selectedDividerOrientation
                            ) { orientation in
                                Text(orientation.name)
                            }
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
