//
//  AddFeedView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/12.
//
//

import FeedKit
import SwiftData
import SwiftUI

@Model
class LocalFeed {
    var id = UUID()
    var feedTitle: String
    var feedURL: String

    init(feedTitle: String, feedURL: String) {
        self.feedTitle = feedTitle
        self.feedURL = feedURL
    }
}

struct AddFeedView: View {
    @State private var feedURL: String = ""
    @State private var isValid: Bool = false

    private func fetchFeed(_ feedURL: URL) async throws {
        let feed = try await Feed(
            url: feedURL)
        
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("URL", text: $feedURL)
            }
            .navigationTitle("Add Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isValid ? "Fetch" : "Save") {
                        Task {
                            let feed = try await Feed(
                                url: URL(string: feedURL)!)
                            switch feed {
                            case let .atom(feed):
                                print("Is atom")  // An AtomFeed instance
                            case let .rss(feed):
                                if let channel = feed.channel {
                                    print(channel)
                                }
                                print("Is rss")  // An RSSFeed instance
                            case let .json(feed):
                                print("Is json")  // A JSONFeed instance
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddFeedView()
}
