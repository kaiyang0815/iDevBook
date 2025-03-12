//
//  SFSymbolsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/11.
//
//

import SwiftUI

struct SFSymbolsView: View {
    @State private var selectedSymbolCategory: ESFSymbolCategory = .whatsNew
    @State private var searchText: String = ""
    @State private var showSymbolInpector: Bool = false
    @State private var selectedSymbol: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 100))], spacing: 20
                ) {
                    ForEach(
                        selectedSymbolCategory.symbols.filter({ symbol in
                            if !searchText.isEmpty {
                                return symbol.localizedStandardContains(searchText)
                            } else {
                                return true
                            }
                        }), id: \.self
                    ) {
                        symbol in
                        VStack(alignment: .center) {
                            Image(systemName: symbol)
                                .font(.largeTitle)
                                .frame(maxWidth: .infinity, minHeight: 100)
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
                            withAnimation {
                                selectedSymbol = symbol
                                showSymbolInpector.toggle()
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("SF Symbols Picker")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: Text("Search"))
            .toolbar {
                Picker("Category", selection: $selectedSymbolCategory) {
                    ForEach(ESFSymbolCategory.allCases) { category in
                        Text(category.name)
                            .tag(category)
                    }
                }
            }
            .sheet(isPresented: $showSymbolInpector) {
                SymbolInspectorView(symbol: $selectedSymbol)
            }
        }
    }
}

#Preview {
    SFSymbolsView()
}
