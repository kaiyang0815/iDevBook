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
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(selectedSymbolCategory.symbols, id: \.self) {
                        symbol in
                        VStack(alignment: .center) {
                            Image(systemName: symbol)
                                .frame(maxWidth: .infinity, minHeight: 80)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.secondary, lineWidth: 1)
                                }
                            Text(symbol)
                                .font(.caption)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxHeight: .infinity)
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
        }
    }
}

#Preview {
    SFSymbolsView()
}
