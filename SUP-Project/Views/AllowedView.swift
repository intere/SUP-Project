//
//  AllowedView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/5/22.
//

import SwiftUI

struct TitleWithBulletsModel {
    let title: String
    let bullets: [String]
    let textColor: Color
}

struct TitleWithBulletListView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var model: TitleWithBulletsModel

    var backgroundFill: Color {
        switch colorScheme {
        case .light:
            return .gray.opacity(0.75)
        case .dark:
            return .black.opacity(0.5)
        @unknown default:
            fatalError()
        }
    }

    var body: some View {
        if model.bullets.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 2) {
                Text(model.title).font(.title3)
                    .foregroundColor(model.textColor)
                    .shadow(color: .black.opacity(0.7), radius: 3, x: 1, y: 1)
                ForEach(model.bullets, id: \.self) { bullet in
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 5, height: 5, alignment: .center)
                            .foregroundColor(model.textColor)
                        Text(bullet)
                            .foregroundColor(model.textColor)
                            .shadow(color: .black.opacity(0.7), radius: 3, x: 1, y: 1)
                    }.padding(0)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(backgroundFill)
            )
        }
    }
}

struct DisallowedView: View {
    let place: Place

    var body: some View {
        TitleWithBulletListView(
            model: .init(
                title: "Prohibited Watercraft",
                bullets: place.prohibitedWatercraft.map({$0.title}),
                textColor: .red))
    }
}

struct AllowedView: View {
    let place: Place

    var body: some View {
        TitleWithBulletListView(
            model: .init(
                title: "Permitted Watercraft",
                bullets: place.allowedWatercraft.map({$0.title}),
                textColor: .green))
    }
}

struct AllowedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AllowedView(place: MapContentService().places[3]).preferredColorScheme(.dark)
            DisallowedView(place: MapContentService().places[0]).preferredColorScheme(.dark)
            AllowedView(place: MapContentService().places[3]).preferredColorScheme(.light)
            DisallowedView(place: MapContentService().places[0]).preferredColorScheme(.light)
        }.background(PleasantBackgroundView())
    }
}
