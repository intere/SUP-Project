//
//  SUP_ProjectApp.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import SwiftUI

@main
struct SUP_ProjectApp: App {
    let theme = Theme()

    var body: some Scene {
        WindowGroup {
            MainView(theme: theme)
        }
    }
}
