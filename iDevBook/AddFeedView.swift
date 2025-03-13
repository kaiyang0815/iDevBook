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
    @State private var feedURL: String = "https://fatbobman.com/zh/rss.xml"
    @State private var feedTitle: String = ""
    @State private var isValid: Bool = false
    @State private var fetching: Bool = false

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("URL", text: $feedURL)
                    TextField("Title", text: $feedTitle)
                } header: {
                    Text("Info")
                } footer: {
                    Text("Title is optional.")
                }
            }
            .navigationTitle("Add Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if isValid {
                            let newFeed = LocalFeed(
                                feedTitle: feedTitle, feedURL: feedURL)
                            modelContext.insert(newFeed)
                            dismiss()
                        } else {
                            Task {
                                fetching.toggle()
                                let feed = try await Feed(
                                    url: URL(string: feedURL)!)
                                switch feed {
                                case .atom(_):
                                    print("Is atom")  // An AtomFeed instance
                                case let .rss(feed):
                                    if let channel = feed.channel,
                                        let title = channel.title
                                    {
                                        feedTitle = title
                                    }
                                    fetching.toggle()
                                    isValid.toggle()
                                    print("Is rss")  // An RSSFeed instance
                                case .json(_):
                                    print("Is json")  // A JSONFeed instance
                                }
                            }
                        }
                    } label: {
                        if fetching {
                            ProgressView()
                        } else {
                            if isValid {
                                Text("Save")
                            } else {
                                Text("Fetch")
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
