//
//  ArticlesView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/5.
//
//

import FeedKit
import SwiftUI

struct ArticlesView: View {
    var body: some View {
        NavigationStack {
            List {

            }
            .navigationTitle("Articles")
            .onAppear {
                Task {
                    let feed = try await Feed(
                        url: URL(string: "https://fatbobman.com/zh/rss.xml")!)
                    switch feed {
                    case let .atom(feed):
                        print("Is atom")// An AtomFeed instance
                    case let .rss(feed):
                        if let channel = feed.channel {
                            print(channel)
                        }
                        print("Is rss")// An RSSFeed instance
                    case let .json(feed):
                        print("Is json")// A JSONFeed instance
                    }
                }
            }
        }
    }
}

#Preview {
    ArticlesView()
}
