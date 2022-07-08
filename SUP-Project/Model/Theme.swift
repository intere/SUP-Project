//
//  Theme.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/8/22.
//

import SwiftUI

struct Theme {
    @Environment(\.colorScheme) var colorScheme

    var navigationTextColor: Color {
        switch colorScheme {
        case .dark:
            return .white
        case .light:
            return .black
        @unknown default:
            fatalError()
        }
    }
}
