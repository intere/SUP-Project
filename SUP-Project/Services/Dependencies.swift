//
//  Dependencies.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/21/22.
//

import Foundation

class Dependencies {
    var theme: Theme
    var logger: Logging

    init(
        theme: Theme = Theme(),
        logger: Logging = Logger.shared
    ) {
        self.theme = theme
        self.logger = logger
    }
}
