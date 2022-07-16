//
//  PlacesDatabase.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/16/22.
//

import FirebaseDatabase

class PlacesDatabase {
    static let shared = PlacesDatabase()

    let database = Database.database().reference()
}
