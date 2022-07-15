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
    let theme: Theme
    @State var model: TitleWithBulletsModel

    var backgroundFill: Color {
        theme.bulletBackgroundColor.opacity(0.8)
    }

    var body: some View {
        if model.bullets.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 2) {
                Text(model.title).font(.title3)
                    .foregroundColor(model.textColor)
                ForEach(model.bullets, id: \.self) { bullet in
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 5, height: 5, alignment: .center)
                            .foregroundColor(model.textColor)
                        Text(bullet)
                            .foregroundColor(model.textColor)
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
    let theme: Theme
    let place: Place

    var body: some View {
        TitleWithBulletListView(
            theme: theme, model: .init(
                title: "Prohibited Watercraft",
                bullets: place.prohibitedWatercraft.map({$0.title}),
                textColor: .appQuinary))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
    }
}

struct AllowedView: View {
    let theme: Theme
    let place: Place

    var body: some View {
        TitleWithBulletListView(
            theme: theme,
            model: .init(
                title: "Permitted Watercraft",
                bullets: place.allowedWatercraft.map({$0.title}),
                textColor: .appPrimary))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
    }
}

struct AllowedView_Previews: PreviewProvider {
    private static let theme = Theme()
    static var previews: some View {
        VStack(spacing: 40) {
            AllowedView(theme: theme, place: MapContentService().places[3])
                .preferredColorScheme(.dark)
                .padding()
            DisallowedView(theme: theme, place: MapContentService().places[1])
                .preferredColorScheme(.dark)
                .padding()
        }
        .background(theme.appBackground)
        .padding()

        VStack {
            AllowedView(theme: theme, place: MapContentService().places[3])
                .preferredColorScheme(.light)
                .padding()
            DisallowedView(theme: theme, place: MapContentService().places[1])
                .preferredColorScheme(.light)
                .padding()
        }
        .background(theme.appBackground)
        .padding()
    }
}
