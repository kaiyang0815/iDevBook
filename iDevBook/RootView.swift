//
//  RootView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/5.
//
//

import SwiftUI

enum RootTab: String, CaseIterable, Identifiable {
    case book = "Book"
    case article = "Articles"
    case setting = "Settings"
    case search = "Search"
    case newsletter = "Newsletter"

    var id: Self {
        return self
    }

    var symbol: String {
        switch self {
        case .book:
            "book.pages"
        case .article:
            "newspaper"
        case .setting:
            "gearshape"
        case .search:
            "magnifyingglass"
        case .newsletter:
            "bell"
        }
    }
}

struct RootView: View {
    @State private var selectedTab: RootTab = .book

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                RootTab.book.rawValue, systemImage: RootTab.book.symbol,
                value: .book
            ) {
                MainView()
            }
            Tab(
                RootTab.article.rawValue, systemImage: RootTab.article.symbol,
                value: .article
            ) {
                ArticlesView()
            }
            Tab(
                RootTab.newsletter.rawValue,
                systemImage: RootTab.newsletter.symbol, value: .newsletter
            ) {
                NewslettersView()
            }
            .tabPlacement(.pinned)
            Tab(value: .search, role: .search) {
                SearchView()
            }
            Tab(
                RootTab.setting.rawValue, systemImage: RootTab.setting.symbol,
                value: .setting
            ) {
                SettingsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    RootView()
}
