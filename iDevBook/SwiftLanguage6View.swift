//
// SwiftLanguage6View.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import HighlightSwift
import SwiftUI

struct SwiftLanguage6View: View {
    let someCode: String = """
        print(\"Hello World\")
        """
    var body: some View {
        CodeText(someCode)
            .highlightLanguage(.swift)
            .codeTextStyle(.card)
            .codeTextColors(.theme(.github))
    }
}

#Preview {
    SwiftLanguage6View()
}
