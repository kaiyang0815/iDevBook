//
// AcknowledgementsView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import AcknowList
import SwiftUI

struct AcknowledgementsView: View {
    var body: some View {
        NavigationStack {
            if let url = Bundle.main.url(
                forResource: "Package", withExtension: "resolved"),
                let data = try? Data(contentsOf: url),
                let acknowList = try? AcknowPackageDecoder().decode(
                    from: data)
            {
                List {
                    Section {
                        ForEach(acknowList.acknowledgements) { acknowledgement in
                            NavigationLink {
                                AcknowledgementDetailsView(acknowledgement: acknowledgement)
                            } label: {
                                Text(acknowledgement.title)
                            }
                        }
                    } header: {
                        Text("Licenses")
                    } footer: {
                        Text("All third party libraries.")
                    }
                }
                .navigationTitle("Acknowledgements")
            }
        }
    }
}

#Preview {
    AcknowledgementsView()
}
