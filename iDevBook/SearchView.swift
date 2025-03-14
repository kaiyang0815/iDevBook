//
// SearchView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftUI

#if os(macOS)
typealias PlatformColor = NSColor
#else
typealias PlatformColor = UIColor
#endif

enum SearchScope: String, CaseIterable, Identifiable, Hashable {
    case docs
    case article
    case newsletter
    
    var id: Self {
        return self
    }
    
    var name: String {
        switch self {
        case .docs:
            "Docs"
        case .article:
            "Art"
        case .newsletter:
            "News"
        }
    }
}

struct SearchView: View {
    @State private var searchScope: SearchScope = .docs
    @State private var searchText: String = ""

    @ViewBuilder
    func docsSuggestionsList() -> some View {
        List {
            
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(PlatformColor.systemGray))
                        .frame(height: 120)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(PlatformColor.systemGray))
                        .frame(height: 120)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(PlatformColor.systemGray))
                        .frame(height: 120)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(PlatformColor.systemGray))
                        .frame(height: 120)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(PlatformColor.systemGray))
                        .frame(height: 120)
                }
                .padding()
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: Text("Search..."))
            .searchSuggestions {
                HStack {
                    Text("Recently searched")
                        .fontWeight(.semibold)
                    Spacer()
                    Button("Clear") {
                        
                    }
                }
                docsSuggestionsList()
            }
            .searchScopes($searchScope) {
                ForEach(SearchScope.allCases) { scope in
                    Text(scope.name)
                        .tag(scope)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
