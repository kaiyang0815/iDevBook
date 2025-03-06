//
// LexicalDemoView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import Lexical
import LexicalInlineImagePlugin
import LexicalLinkPlugin
import LexicalListPlugin
import SwiftUI

struct LexicalDemoView: View {
    @State private var store = LexicalStore()
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    store.dispatchCommand(
                        type: .formatText, payload: TextFormatType.bold)
                } label: {
                    Image(systemName: "bold")
                        .foregroundStyle(store.isBold ? .primary : .secondary)
                }.keyboardShortcut("b")

                LexicalEditorView(store: store)
                    .frame(height: 300)
                    .border(Color.gray, width: 1)
                    .padding()
            }
            .navigationTitle("Lexical ios demo")
            .toolbar {
                Link(
                    destination: URL(
                        string: "https://github.com/facebook/lexical-ios")!
                ) {
                    Label("Repo", systemImage: "safari")
                }
            }
        }

    }
}

@Observable
class LexicalStore {
    var view: LexicalView? = nil
    var theme: Theme
    var isBold: Bool = false
    var isItalic: Bool = false
    var editorState: EditorState? {
        view?.editor.getEditorState()
    }

    var editor: Editor? {
        view?.editor
    }

    func dispatchCommand(type: CommandType, payload: Any?) {
        view?.editor.dispatchCommand(type: type, payload: payload)
    }

    func update(closure: @escaping () throws -> Void) throws {
        try view?.editor.update(closure)
    }

    init(
        view: LexicalView? = nil, theme: Theme = Theme()
    ) {
        self.view = view
        self.theme = theme

        theme.paragraph = [
            .fontSize: 24.0,
            .lineHeight: 24.0,
        ]
    }
}

struct LexicalEditorView: UIViewRepresentable {
    public var store: LexicalStore

    func makeUIView(context: Context) -> LexicalView {
        // set up your plugins
        let listPlugin = ListPlugin()
        let linkPlugin = LinkPlugin()
        let imagePlugin = InlineImagePlugin()

        // set up your theme
        let theme = Theme()
        theme.paragraph = [
            .fontSize: CGFloat(15),
            .foregroundColor: UIColor.black,
        ]

        // create the view
        let lexicalView = LexicalView(
            editorConfig: EditorConfig(
                theme: theme,
                plugins: [listPlugin, linkPlugin, imagePlugin]
            ),
            featureFlags: FeatureFlags(),
            placeholderText: LexicalPlaceholderText(
                text: "write here...", font: .systemFont(ofSize: 18),
                color: UIColor.placeholderText)
        )

        store.view = lexicalView

        _ = lexicalView.editor.registerUpdateListener {
            activeEditorState, previousEditorState, dirtyNodes in
            updateStoreState()
        }

        return lexicalView
    }

    func updateUIView(_ uiView: Lexical.LexicalView, context: Context) {
        uiView.placeholderText = LexicalPlaceholderText(
            text: "...", font: .systemFont(ofSize: 15),
            color: UIColor.placeholderText)
    }

    func updateStoreState() {
        if let selection = try? getSelection() as? RangeSelection {
            store.isBold = selection.hasFormat(type: .bold)
        }
    }
}

#Preview {
    LexicalDemoView()
}
