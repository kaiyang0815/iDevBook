//
// ArticleDetailsView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import FeedKit
import SwiftUI

struct ArticleDetailsView: View {
    let feedItem: RSSFeedItem

    @State private var hideTabBar: Bool = false
    @State private var contentHeight: CGFloat = .zero
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(feedItem.title ?? "")
                        .font(.title)
                }
                .padding(.horizontal)
            }
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
    ArticleDetailsView(feedItem: RSSFeedItem(title: "Title"))
}
