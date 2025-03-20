//
// AppShortcutsDemoView.swift
// iDevBook
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import AppIntents
import SwiftData
import SwiftUI

#if os(iOS)
@Model
class ShortCutsItem {
    var inputText: String
    var createdAt: Date
    @Attribute(.externalStorage)
    var inputData: Data

    var uiImage: UIImage? {
        .init(data: inputData)
    }

    init(inputText: String, createdAt: Date = .now, inputData: Data) {
        self.inputText = inputText
        self.createdAt = createdAt
        self.inputData = inputData
    }
}

struct AddItemIntent: AppIntent {
    static var title: LocalizedStringResource = "Add New Item"
    
    @Parameter(
        title: .init(stringLiteral: "Chose a Image"),
        description: "The item will be added to iDevBook",
        supportedContentTypes: [.image],
        inputConnectionBehavior: .connectToPreviousIntentResult
    ) var imageFile: IntentFile
    
    @Parameter(title: "inputText") var inputText: String
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let container = try ModelContainer(for: ShortCutsItem.self)
        let context = ModelContext(container)
        
        let imageData = try await imageFile.data(contentType: .image)
        let item = ShortCutsItem(inputText: inputText, inputData: imageData)
        
        context.insert(item)
        try context.save()
        
        return .result(dialog: "Memory added successfully!")
    }
}

struct AddMemoryShortcut: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddItemIntent(),
            phrases: ["Create a new \(.applicationName)"],
            shortTitle: "Create New Item",
            systemImageName: "list.bullet.clipboard"
        )
    }
}

struct AppShortcutsDemoView: View {
    @Query
    var items: [ShortCutsItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Section {
                        if let uiImage = item.uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("App Shortcuts Demo")
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("No Data yet.", systemImage: "tray.fill", description: Text("Add data by shortcuts"))
                }
            }
        }
    }
}

#Preview {
    AppShortcutsDemoView()
}
#endif

