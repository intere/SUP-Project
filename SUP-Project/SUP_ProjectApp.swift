//
//  SUP_ProjectApp.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
        return true
    }
}

@main
struct SUP_ProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let theme = Theme()

    var body: some Scene {
        WindowGroup {
            MainView(theme: theme)
        }
    }
}
