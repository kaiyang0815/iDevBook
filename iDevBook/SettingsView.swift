//
//  SettingsView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/5.
//
//

import SwiftUI
import AcknowList

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    AcknowListSwiftUIView(acknowledgements: [])
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("3rd Party Libraries")
                            }
                        }
                } label: {
                    Label("AcknowList", systemImage: "list.clipboard")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
