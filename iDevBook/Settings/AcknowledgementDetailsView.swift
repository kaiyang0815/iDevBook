//
// AcknowledgementDetailsView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// Raw code from AcknowList
// All Rights Reserved.

import AcknowList
import SwiftUI

struct AcknowledgementDetailsView: View {
    @State public var acknowledgement: Acknow

    public var body: some View {
        #if os(macOS)
            ScrollView {
                Text(acknowledgement.title)
                    .font(.title)
                    .padding()
                Text(acknowledgement.text ?? "")
                    .font(.body)
                    .padding()
            }
            .onAppear {
                fetchLicenseIfNecessary()
            }
        #else
            NavigationStack {
                ScrollView {
                    VStack {
                        Text(acknowledgement.text ?? "")
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                    }
                }
                .navigationBarTitle(acknowledgement.title)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    fetchLicenseIfNecessary()
                }
            }
        #endif
    }

    private func fetchLicenseIfNecessary() {
        guard acknowledgement.text == nil,
            let repository = acknowledgement.repository,
            GitHubAPI.isGitHubRepository(repository)
        else {
            return
        }

        GitHubAPI.getLicense(for: repository) { result in
            switch result {
            case .success(let text):
                acknowledgement = Acknow(
                    title: acknowledgement.title, text: text,
                    license: acknowledgement.license,
                    repository: acknowledgement.repository)

            case .failure:
                #if os(iOS)
                    UIApplication.shared.open(repository)
                #endif
            }
        }
    }
}

#Preview {
    AcknowledgementDetailsView(
        acknowledgement: Acknow(
            title: "License",
            text: """
                Copyright (c) 2015-2025 Vincent Tourraine (https://www.vtourraine.net)

                Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

                The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

                THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
                """
        )
    )
}
