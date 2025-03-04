//
//  HighlightSwiftView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/4.
//  
//    


import SwiftUI
import HighlightSwift

struct HighlightSwiftView: View {
    @State private var  someCode: String = """
        print(\"Hello World\")
        """
    
    @State private var selectedTheme: HighlightTheme = .a11y
    
    var body: some View {
        List {
            Section("Raw code") {
                TextEditor(text: $someCode)
            }
            Section("Highlighed code") {
                CodeText(someCode)
                    .highlightLanguage(.swift)
                    .codeTextStyle(.card)
                    .codeTextColors(.theme(.github))
            }
            .listRowBackground(Color.clear)
            
            Section {
                Picker("Theme", selection: $selectedTheme) {
                    ForEach(HighlightTheme.allCases) { theme in
                        Text(theme.rawValue)
                    }
                }
            }
        }
    }
}

#Preview {
    HighlightSwiftView()
}
