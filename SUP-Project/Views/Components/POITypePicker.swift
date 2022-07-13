//
//  POITypePicker.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct POITypePicker: View {
    @Binding var selected: POIType

    var body: some View {
        Picker("Type", selection: $selected) {
            ForEach(POIType.allCases, id: \.self) { poi in
                HStack {
                    Text(poi.description)
                    poi.image
                }
            }
        }
        .pickerStyle(.automatic)
    }
}

struct POITypePicker_Previews: PreviewProvider {
    static var model = PreviewModel()

    static var previews: some View {
        POITypePicker(selected: model.$selected)
    }

    struct PreviewModel {
        @State var selected = POIType.allCases.last!
    }
}
