//
//  Theme.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/8/22.
//

import SwiftUI

struct Theme {
    @Environment(\.colorScheme) var colorScheme

    var isDarkMode: Bool {
        colorScheme == .dark
    }

    var appBackground: Color { .appLightGray }

    var contentOverlay: Color { .black.opacity(0.5) }
    var navigationTextColor: Color { isDarkMode ? .white : .black }
    var placeListTextColor: Color { .appPrimary }
    var bulletBackgroundColor: Color { .appTextDark }
    var poiTextColor: Color { .appQuinary }
    var poiBackgroundColor: Color { .appTextDark }
    var poiListColor: Color { .appQuaternary }
}
