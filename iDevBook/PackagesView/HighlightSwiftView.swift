//
//  HighlightSwiftView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/4.
//
//

import HighlightSwift
import SwiftUI

extension HighlightLanguage: @retroactive CaseIterable {
    public static var allCases: [HighlightLanguage] = [
        .appleScript,
        .arduino,
        .awk,
        .bash,
        .basic,
        .c,
        .cPlusPlus,
        .cSharp,
        .clojure,
        .css,
        .dart,
        .delphi,
        .diff,
        .django,
        .dockerfile,
        .elixir,
        .elm,
        .erlang,
        .gherkin,
        .go,
        .gradle,
        .graphQL,
        .haskell,
        .html,
        .java,
        .javaScript,
        .json,
        .julia,
        .kotlin,
        .latex,
        .less,
        .lisp,
        .lua,
        .makefile,
        .markdown,
        .mathematica,
        .matlab,
        .nix,
        .objectiveC,
        .perl,
        .php,
        .phpTemplate,
        .plaintext,
        .postgreSQL,
        .protocolBuffers,
        .python,
        .pythonRepl,
        .r,
        .ruby,
        .rust,
        .scala,
        .scss,
        .shell,
        .sql,
        .swift,
        .toml,
        .typeScript,
        .visualBasic,
        .webAssembly,
        .yaml,
    ]
}

enum CodeTextStyleType: String, CaseIterable, Identifiable {
    case card, plain

    var id: Self {
        return self
    }

    var rawValue: String {
        switch self {
        case .card:
            "Card"
        case .plain:
            "Plain"
        }
    }

    var codeTextStyle: CodeTextStyle {
        switch self {
        case .card:
            .card
        case .plain:
            .plain
        }
    }
}

struct HighlightSwiftView: View {
    @State private var someCode: String = """
        print("Hello, world!")
        // Prints "Hello, world!"
        """

    @State private var selectedTheme: HighlightTheme = .a11y
    @State private var selectedLanguage: HighlightLanguage = .swift
    @State private var selecteedStyle: CodeTextStyleType = .plain
    @State private var showInspector: Bool = true
    @State private var hideTabBar: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Preview") {
                        CardContainerView {
                            CodeText(someCode)
                                .highlightLanguage(selectedLanguage)
                                .codeTextStyle(selecteedStyle.codeTextStyle)
                                .codeTextColors(.theme(selectedTheme))
                                .frame(height: 100)
                        }
                    }
                    .clearSectionStyle()
                }
                .inspector(isPresented: $showInspector) {
                    List {
                        Section("Controll") {
                            TextEditor(text: $someCode)

                            Picker("Style", selection: $selecteedStyle) {
                                ForEach(CodeTextStyleType.allCases, id: \.self)
                                {
                                    style in
                                    Text(style.rawValue)
                                        .tag(style)
                                }
                            }

                            Picker("Theme", selection: $selectedTheme) {
                                ForEach(HighlightTheme.allCases) { theme in
                                    Text(theme.rawValue)
                                        .tag(theme)
                                }
                            }

                            Picker("Language", selection: $selectedLanguage) {
                                ForEach(HighlightLanguage.allCases, id: \.self)
                                {
                                    lang in
                                    Text(lang.rawValue)
                                        .tag(lang)
                                }
                            }
                        }
                    }
                }

            }
            .navigationTitle("HighlightSwift")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarVisibility(
                    hideTabBar ? .hidden : .automatic, for: .tabBar)
            #endif
            .toolbar {
                Menu {
                    Toggle(isOn: $showInspector.animation()) {
                        Label("Show Inspector", systemImage: "info.circle")
                    }
                    RepoLink("https://github.com/appstefan/HighlightSwift")
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
            }
            .onAppear {
                withAnimation {
                    hideTabBar = true
                }
            }
            #if os(iOS)
                .onWillDisappear {
                    withAnimation {
                        showInspector = false
                    }
                }
            #endif
        }
    }
}

#Preview {
    HighlightSwiftView()
}
