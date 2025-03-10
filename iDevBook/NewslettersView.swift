//
//  NewslettersView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/6.
//
//

import SwiftUI

struct Newsletter {
    var id: UUID
    var title: String
    var publishedAt: Date
    var description: String

    init(
        id: UUID = UUID(), title: String, publishedAt: Date, description: String
    ) {
        self.id = id
        self.title = title
        self.publishedAt = publishedAt
        self.description = description
    }
}

struct NewslettersView: View {
    let NewslettersList: [Newsletter] = [
        .init(
            title: "2025 Weekly", publishedAt: .now,
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        )
    ]
    var body: some View {
        NavigationStack {
            List {
                ForEach(NewslettersList.sorted(by: { $0.publishedAt > $1.publishedAt }), id: \.id) { newsletter in
                    Section {
                        NavigationLink {
                            Text(newsletter.description)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(newsletter.title)
                                    .font(.headline)
                                Divider()
                                Text(newsletter.description)
                                    .lineLimit(3)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    } footer: {
                        Text(newsletter.publishedAt, format: .dateTime)
                    }
                }
            }
            .navigationTitle("Newsletters")
        }
    }
}

#Preview {
    NewslettersView()
}
