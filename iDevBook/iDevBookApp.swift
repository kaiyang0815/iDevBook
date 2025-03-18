//
//  iDevBookApp.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/1/29.
//
//

import SwiftData
import SwiftUI

@main
struct iDevBookApp: App {
    var sharedModelContainer: ModelContainer = {
        #if os(iOS)
            let schema = Schema([
                ShortCutsItem.self, LocalFeed.self,
            ])
        #else
            let schema = Schema([
                LocalFeed.self
            ])
        #endif
        let modelConfiguration = ModelConfiguration(
            schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(
                for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    #if os(iOS)
        @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
        .commands {
            CommandMenu("First menu") {
                Button("Print message") {
                    print("Hello World!")
                }.keyboardShortcut("p")

                Button("Print second message") {
                    print("Second message!")
                }

                Divider()

                Button("Print third message") {
                    print("Third message!")
                }
            }
        }
    }
}
#if os(iOS)
    class AppDelegate: NSObject, UIApplicationDelegate {
        static var orientation: UIInterfaceOrientationMask = .all
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication
                .LaunchOptionsKey: Any]? = nil
        ) -> Bool {
            return true
        }
        func application(
            _ application: UIApplication,
            supportedInterfaceOrientationsFor window: UIWindow?
        ) -> UIInterfaceOrientationMask {
            return Self.orientation
        }
    }
#endif
