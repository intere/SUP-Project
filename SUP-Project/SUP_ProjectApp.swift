//
//  SUP_ProjectApp.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import FirebaseCore
import SwiftUI

@main
struct SUP_ProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var dependencies: Dependencies

    init() {
        SUP_ProjectApp.configureApp()
        dependencies = Dependencies()
    }

    var body: some Scene {
        WindowGroup {
            MainView(model: .init(dependencies: dependencies))
        }
    }

    static func configureApp() {
        FirebaseApp.configure()
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        return true
    }
}
