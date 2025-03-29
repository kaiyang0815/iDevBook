//
//  SFSymbolsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/11.
//
//

import SwiftUI

struct SFSymbolsView: View {
    @State private var selectedSymbolCategory: ESFSymbolCategory = .all
    @State private var selectedDisplayStyle: DisplayStyle = .list
    @State private var searchText: String = ""
    @State private var showInspector: Bool = false
    @State private var selectedSymbol: String = ""
    @State private var hideTabBar: Bool = false

    var body: some View {
        NavigationStack {
            Group {
                switch selectedDisplayStyle {
                case .grid:
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: 100))],
                            spacing: 20
                        ) {
                            ForEach(
                                selectedSymbolCategory.symbols.filter({
                                    symbol in
                                    if !searchText.isEmpty {
                                        return symbol.localizedStandardContains(
                                            searchText)
                                    } else {
                                        return true
                                    }
                                }), id: \.self
                            ) {
                                symbol in
                                VStack(alignment: .center) {
                                    Image(systemName: symbol)
                                        .font(.largeTitle)
                                        .frame(
                                            maxWidth: .infinity, minHeight: 100
                                        )
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.ultraThickMaterial)
                                        }
                                    Text(symbol)
                                        .padding(2)
                                        .font(.caption)
                                        .lineLimit(2)
                                        .frame(minHeight: 40, alignment: .top)
                                }
                                .onTapGesture {
                                    selectedSymbol = symbol
                                }
                            }
                        }
                        .padding()
                    }
                case .list:
                    List {
                        ForEach(
                            selectedSymbolCategory.symbols.filter({
                                symbol in
                                if !searchText.isEmpty {
                                    return symbol.localizedStandardContains(
                                        searchText)
                                } else {
                                    return true
                                }
                            }), id: \.self
                        ) {
                            symbol in
                            Label(symbol, systemImage: symbol)
                                .onTapGesture {
                                    selectedSymbol = symbol
                                }
                        }
                    }
                case .gallery:
                    Text("gallery")
                }
            }
            .navigationTitle("SF Symbols Picker")
            .searchable(text: $searchText, prompt: Text("Search"))
            .toolbar {
                ToolbarItemGroup(placement: .secondaryAction) {
                    Picker(selection: $selectedSymbolCategory) {
                        ForEach(ESFSymbolCategory.allCases) { category in
                            Label(
                                category.name, systemImage: category.labelSymbol
                            )
                            .tag(category)
                        }
                    } label: {
                        Label(
                            "Category", systemImage: "chevron.up.chevron.down")
                    }
                    .pickerStyle(.menu)
                    Button {
                        withAnimation {
                            showInspector.toggle()
                        }
                    } label: {
                        Label("Show Inspector", systemImage: "info.circle")
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Picker("Display", selection: $selectedDisplayStyle) {
                        ForEach(DisplayStyle.allCases, id: \.self) { style in
                            Label(style.name, systemImage: style.symbol)
                        }
                    }
                }
            }
            .inspector(isPresented: $showInspector) {
                SymbolInspectorView(symbol: $selectedSymbol)
            }
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .onAppear {
                withAnimation {
                    selectedSymbol = selectedSymbolCategory.symbols.first!
                    hideTabBar.toggle()
                }
            }
            #if os(iOS)
                .onWillDisappear {
                    withAnimation {
                        showInspector = false
                    }
                }
            #endif
            .onChange(of: selectedSymbolCategory) { _, _ in
                selectedSymbol = selectedSymbolCategory.symbols.first!
            }
        }
    }
}

#Preview {
    SFSymbolsView()
}
