//
//  POITypePicker.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/13/22.
//

import SwiftUI

struct POITypePicker: View {
    let theme: Theme
    @Binding var selected: POIType

    var body: some View {
        Picker("Type", selection: $selected) {
            ForEach(POIType.allCases, id: \.self) { poi in
                HStack {
                    Text(poi.description)
                        .foregroundColor(theme.poiTextColor)
                    poi.image
                        .renderingMode(.template)
                        .foregroundColor(theme.poiTextColor)
                }
            }
        }
        .accentColor(theme.poiTextColor)
        .pickerStyle(.automatic)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(theme.poiBackgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(theme.poiBackgroundColor)
        )
    }
}

struct POITypePicker_Previews: PreviewProvider {
    static var model = PreviewModel()

    static var previews: some View {
        POITypePicker(theme: .init(), selected: model.$selected)
    }

    struct PreviewModel {
        @State var selected = POIType.allCases.last!
    }
}
