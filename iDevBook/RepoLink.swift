//
// RepoLink.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI

struct RepoLink: View {
    let url: String
    init(_ url: String) {
        self.url = url
    }
    var body: some View {
        Link(
            destination: URL(
                string: url)!
        ) {
            Label("Repo", systemImage: "safari")
        }
    }
}

#Preview {
    RepoLink("https://github.com/facebook/lexical-ios")
}
