//
//  SUP_ProjectApp.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/2/22.
//

import SwiftUI

@main
struct SUP_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(places: MapContentService().places)
        }
    }
}
