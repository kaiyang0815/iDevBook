//
//  OpenAIView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/28.
//
//

import OpenAI
import SwiftUI

struct OpenAIView: View {
    @State private var selectedModel: Model = .ada
    @State private var isThirdPartyAPI: Bool = false
    @State private var token: String = ""
    @State private var api: String = ""

    @State private var showInspector: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CardContainerView {
                        
                    }
                }
                .clearSectionStyle()
            }
            #if os(iOS)
                .navigationTitle("OpenAI")
                .navigationBarTitleDisplayMode(.inline)
            #endif
            .inspector(isPresented: $showInspector) {
                Form {
                    Section {
                        TextField("Token", text: $token)
                        Toggle(isOn: $isThirdPartyAPI) {
                            Text("Third Party API")
                        }
                        if isThirdPartyAPI {
                            TextField("API", text: $api)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OpenAIView()
}
