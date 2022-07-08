//
//  ColorExtensions.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/8/22.
//

import SwiftUI

extension Color {
    init(_ hex: Int) {
        let red = (hex & 0xff0000) >> 16
        let green = (hex & 0xff00) >> 8
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue)
    }

    init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 0xff, green: CGFloat(green) / 0xff, blue: CGFloat(blue) / 0xff)
    }

    static let appPrimary = Color(0x8ECAE6)
    static let appSecondary = Color(0x219EBC)
    static let appTirtiary = Color(0x023047)
    static let appQuaternary = Color(0xFFB703)
    static let appQuinary = Color(0xFB8500)

    static let appLightGray = Color(0xCFCFCF)
    static let appTextDark = Color(0x555555)
    static let appTextLight = Color(0xEFEFEF)
}

struct ColorExtensions_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                ColorPreview(color: .appPrimary)
                ColorPreview(color: .appSecondary)
                ColorPreview(color: .appTirtiary)
                ColorPreview(color: .appQuaternary)
                ColorPreview(color: .appQuinary)
            }
            .padding(.bottom, 40)
            VStack {
                ColorPreview(color: .appLightGray)
                ColorPreview(color: .appTextDark)
                ColorPreview(color: .appTextLight)
                Spacer()
            }
        }
        .padding()
    }

    struct ColorPreview: View {
        var color: Color

        var body: some View {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.red, lineWidth: 1)
                )
        }
    }
}
