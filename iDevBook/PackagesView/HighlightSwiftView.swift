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

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Preview") {
                        CodeText(someCode)
                            .highlightLanguage(selectedLanguage)
                            .codeTextStyle(selecteedStyle.codeTextStyle)
                            .codeTextColors(.theme(selectedTheme))
                            .frame(height: 100)
                    }
                }
                .scrollDisabled(true)
                .frame(height: 280)
                Divider()
                List {
                    Section("Controll") {
                        TextEditor(text: $someCode)

                        Picker("Style", selection: $selecteedStyle) {
                            ForEach(CodeTextStyleType.allCases, id: \.self) {
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
                            ForEach(HighlightLanguage.allCases, id: \.self) {
                                lang in
                                Text(lang.rawValue)
                                    .tag(lang)
                            }
                        }
                    }
                }
            }
            .navigationTitle("HighlightSwift Demo")
            .toolbar {
                RepoLink("https://github.com/appstefan/HighlightSwift")
            }
        }
    }
}

#Preview {
    HighlightSwiftView()
}
