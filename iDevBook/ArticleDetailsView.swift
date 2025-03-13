//
// ArticleDetailsView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI
import FeedKit

struct ArticleDetailsView: View {
    let feedItem: RSSFeedItem
    
    @State private var hideTabBar: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    Text(feedItem.content?.encoded ?? "")
                }
            }
            .navigationTitle(feedItem.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarVisibility(hideTabBar ? .hidden : .automatic, for: .tabBar)
            .onAppear {
                withAnimation {
                    hideTabBar.toggle()
                }
            }
        }
    }
}

#Preview {
    ArticleDetailsView(feedItem: RSSFeedItem())
}
