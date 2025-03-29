//
//  OpenAIView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/28.
//
//

import OpenAI
import SwiftUI

enum EModel: String, CaseIterable, Identifiable {
    // o3 series
    case o3_mini = "o3-mini"

    // o1 series
    case o1 = "o1"
    case o1_mini = "o1-mini"

    // GPT-4
    case gpt4_o = "gpt-4o"
    case gpt4_o_mini = "gpt-4o-mini"
    case gpt4_turbo = "gpt-4-turbo"
    case gpt4_turbo_preview = "gpt-4-turbo-preview"
    case gpt4_vision_preview = "gpt-4-vision-preview"
    case gpt4_0125_preview = "gpt-4-0125-preview"
    case gpt4_1106_preview = "gpt-4-1106-preview"
    case gpt4 = "gpt-4"
    case gpt4_0613 = "gpt-4-0613"
    case gpt4_0314 = "gpt-4-0314"
    case gpt4_32k = "gpt-4-32k"
    case gpt4_32k_0613 = "gpt-4-32k-0613"
    case gpt4_32k_0314 = "gpt-4-32k-0314"
    case gpt4_5_preview = "gpt-4.5-preview"

    // GPT-3.5
    case gpt3_5Turbo = "gpt-3.5-turbo"
    case gpt3_5Turbo_0125 = "gpt-3.5-turbo-0125"
    case gpt3_5Turbo_1106 = "gpt-3.5-turbo-1106"
    case gpt3_5Turbo_0613 = "gpt-3.5-turbo-0613"
    case gpt3_5Turbo_0301 = "gpt-3.5-turbo-0301"
    case gpt3_5Turbo_16k = "gpt-3.5-turbo-16k"
    case gpt3_5Turbo_16k_0613 = "gpt-3.5-turbo-16k-0613"

    // Speech
    case gpt_4o_mini_tts = "gpt-4o-mini-tts"
    case tts_1 = "tts-1"
    case tts_1_hd = "tts-1-hd"

    // Transcriptions / Translations
    case whisper_1 = "whisper-1"

    // Image Generation
    case dall_e_2 = "dall-e-2"
    case dall_e_3 = "dall-e-3"

    // Fine Tunes
    case davinci = "davinci"
    case curie = "curie"
    case babbage = "babbage"
    case ada = "ada"

    // Embeddings
    case textEmbeddingAda = "text-embedding-ada-002"
    case textSearchAda = "text-search-ada-doc-001"
    case textSearchBabbageDoc = "text-search-babbage-doc-001"
    case textSearchBabbageQuery001 = "text-search-babbage-query-001"
    case textEmbedding3 = "text-embedding-3-small"
    case textEmbedding3Large = "text-embedding-3-large"

    // Moderations
    case textModerationStable = "text-moderation-stable"
    case textModerationLatest = "text-moderation-latest"
    case moderation = "text-moderation-007"

    // 初始化方法，支持从字符串转换为 EModel
    init?(from model: String) {
        self.init(rawValue: model)
    }

    var id: Self { self }
}

struct OpenAIView: View {
    @State private var selectedModel: EModel = .gpt4_o_mini
    @State private var isThirdPartyAPI: Bool = false
    @State private var token: String = ""
    @State private var api: String = "api.openai.com"
    @State private var chatResponse: String = "No response"
    @State private var userMessage: String = "who ary you?"

    @State private var showInspector: Bool = true
    @State private var isWaitingResponse: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preview") {
                    CardContainerView {
                        if isWaitingResponse {
                            ProgressView()
                        } else {
                            Text(chatResponse)
                        }
                    }
                }
                .clearSectionStyle()
            }
            #if os(iOS)
                .navigationTitle("OpenAI")
                .navigationBarTitleDisplayMode(.inline)
                .onTapGesture(count: 2) {
                    withAnimation {
                        showInspector.toggle()
                    }
                }
            #endif
            .inspector(isPresented: $showInspector) {
                Form {
                    Section {
                        Picker("Model", selection: $selectedModel) {
                            ForEach(EModel.allCases) { model in
                                Text(model.rawValue)
                                    .tag(model)
                            }
                        }
                        TextField("Token", text: $token, axis: .vertical)
                        ZStack(alignment: .trailing) {
                            TextField(
                                "Message", text: $userMessage, axis: .vertical)
                            if !userMessage.isEmpty {
                                Button {
                                    withAnimation {
                                        userMessage = ""
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.secondary)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        Toggle(isOn: $isThirdPartyAPI) {
                            Text("Third Party API")
                        }
                        if isThirdPartyAPI {
                            ZStack(alignment: .trailing) {
                                TextField("API", text: $api)
                                if !api.isEmpty {
                                    Button {
                                        withAnimation {
                                            api = ""
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(.secondary)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    Section {
                        Button {
                            Task {
                                isWaitingResponse = true
                                let configuration = OpenAI.Configuration(
                                    token: token, host: api)
                                let openAI = OpenAI(
                                    configuration: configuration)
                                let query = ChatQuery(
                                    messages: [
                                        .user(
                                            .init(
                                                content: .string(userMessage)
                                            ))
                                    ],
                                    model: selectedModel.rawValue)
                                let result = try await openAI.chats(
                                    query: query)
                                print(result)
                                chatResponse =
                                    result.choices.first!.message.content
                                    ?? "None"
                                isWaitingResponse = false
                            }
                        } label: {
                            Label("Start Chat", systemImage: "message")
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
