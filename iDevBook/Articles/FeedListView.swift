//
// FeedListView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftData
import SwiftUI

struct FeedListView: View {
    @Query
    var feedList: [LocalFeed]

    var body: some View {
        NavigationStack {
            List {
                ForEach(feedList) { feed in
                    Text(feed.feedTitle)
                }
            }
            .navigationTitle("Feed list")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
}

#Preview {
    FeedListView()
        .modelContainer(for: LocalFeed.self)
}
