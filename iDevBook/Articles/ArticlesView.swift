//
//  ArticlesView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/5.
//
//

import FeedKit
import SwiftData
import SwiftUI

struct ArticlesView: View {
    @State private var showAddFeedView: Bool = false
    @State private var showFeedListView: Bool = false

    @Query
    var feedList: [LocalFeed]

    func getAllItems(_ feedList: [LocalFeed]) async -> [RSSFeedItem] {
        var allItems: [RSSFeedItem] = []

        for item in feedList {
            guard let url = URL(string: item.feedURL) else { continue }

            do {
                let feed = try await Feed(url: url)
                switch feed {
                case .atom(_):
                    print("Is atom")  // AtomFeed 处理逻辑
                case let .rss(feed):
                    if let channel = feed.channel, let items = channel.items {
                        allItems.append(contentsOf: items)
                    }
                case .json(_):
                    print("Is json")  // JSONFeed 处理逻辑
                }
            } catch {
                print("Failed to fetch feed: \(error)")
            }
        }

        return allItems
    }
    @State private var allItems: [RSSFeedItem] = []
    @State private var isFetchingItems: Bool = false

    let dateFormatter = Date.FormatStyle(date: .numeric, time: .shortened)

    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    allItems.sorted(by: {
                        $0.pubDate ?? .now > $1.pubDate ?? .now
                    }), id: \.link
                ) { feedItem in
                    NavigationLink {
                        ArticleDetailsView(feedItem: feedItem)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(feedItem.title ?? "")

                            Text(feedItem.description ?? "")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(3)

                            Divider()
                            Text(
                                feedItem.pubDate ?? .now, format: dateFormatter
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }

                }
            }
            .navigationTitle("Articles")
            .listRowSpacing(10)
            .overlay {
                if isFetchingItems {
                    VStack {
                        ProgressView()
                    }
                } else if allItems.isEmpty {
                    ContentUnavailableView("No aritcles", systemImage: "tray.fill")
                }
            }
            .toolbar {
                Menu {
                    Button {
                        withAnimation {
                            showAddFeedView.toggle()
                        }
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                    }
                    Button {
                        withAnimation {
                            showFeedListView.toggle()
                        }
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
            }
            .sheet(isPresented: $showAddFeedView) {
                AddFeedView()
            }
            .sheet(isPresented: $showFeedListView) {
                FeedListView()
            }
            .onAppear {
                Task {
                    isFetchingItems = true
                    allItems = await getAllItems(feedList)
                    isFetchingItems = false
                }
            }
            .onChange(of: feedList) { _, _ in
                Task {
                    isFetchingItems = true
                    allItems = await getAllItems(feedList)
                    isFetchingItems = false
                }
            }
            .refreshable {
                Task {
                    isFetchingItems = true
                    allItems = await getAllItems(feedList)
                    isFetchingItems = false
                }
            }
        }
    }
}

#Preview {
    ArticlesView()
        .modelContainer(for: LocalFeed.self)
}
