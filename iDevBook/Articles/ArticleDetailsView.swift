//
// ArticleDetailsView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import FeedKit
import RichText
import SwiftUI

struct ArticleDetailsView: View {
    let feedItem: RSSFeedItem

    @State private var hideTabBar: Bool = false
    @State private var contentHeight: CGFloat = .zero
    var body: some View {
        NavigationStack {
            ScrollView {
                RichText(html: feedItem.content?.encoded ?? "")
                    .colorScheme(.auto)
                    .imageRadius(12)
                    .fontType(.system)
#if os(iOS)
                    .foregroundColor(light: Color.primary, dark: Color.primary)
                    .linkColor(light: Color.blue, dark: Color.blue)
                    .colorPreference(forceColor: .onlyLinks)
                    .linkOpenType(.SFSafariView())
#endif
                    .customCSS("")
                    .placeholder {
                        ProgressView()
                    }
                    .transition(.easeOut)
                    .padding()
            }
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarVisibility(hideTabBar ? .hidden : .automatic, for: .tabBar)
#endif
            .onAppear {
                withAnimation {
                    hideTabBar.toggle()
                }
                print(feedItem.content?.encoded ?? "")
            }
        }
    }
}

#Preview {
    ArticleDetailsView(feedItem: RSSFeedItem(title: "Title"))
}
