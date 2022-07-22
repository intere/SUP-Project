//
//  Dependencies.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/21/22.
//

import Foundation

class Dependencies {
    let theme: Theme
    let logger: Logging
    let mapContentProvider: MapContentProviding
    let poiProvider: POIProviding
    let accountProvider: AccountProviding

    init(
        theme: Theme = Theme(),
        logger: Logging = Logger.shared,
        mapContentProvider: MapContentProviding = MapContentService(),
        poiProvider: POIProviding = POIService(),
        accountProvider: AccountProviding = AccountService.shared
    ) {
        self.theme = theme
        self.logger = logger
        self.mapContentProvider = mapContentProvider
        self.poiProvider = poiProvider
        self.accountProvider = accountProvider
    }
}
