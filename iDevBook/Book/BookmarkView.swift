//
//  BookmarkView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/2/2.
//  
//    


import SwiftUI

struct BookmarkView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Blog") {
                    Link(
                        "肘子的 Swift 记事本",
                        destination: URL(string: "https://fatbobman.com/zh/")!
                    )
                }
                Section("Documation") {
                    Link(
                        "Swift Documentation",
                        destination: URL(string: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language")!
                    )
                }
            }
            .navigationTitle("Bookmark")
        }
    }
}

#Preview {
    BookmarkView()
}
