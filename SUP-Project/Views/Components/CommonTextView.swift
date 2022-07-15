//
//  CommonTextView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/14/22.
//

import SwiftUI

// MARK: - CommonViewModel

struct CommonViewModel {
    let textColor: Color
    let backgrounColor: Color

    static let primary = CommonViewModel(textColor: .appTextDark, backgrounColor: .appPrimary)
    static let secondary = CommonViewModel(textColor: .appTextLight, backgrounColor: .appSecondary)
    static let tirtiary = CommonViewModel(textColor: .appTextLight, backgrounColor: .appTirtiary)
    static let quaternary = CommonViewModel(textColor: .appTextDark, backgrounColor: .appQuaternary)
    static let quinary = CommonViewModel(textColor: .appTextLight, backgrounColor: .appQuinary)
    static let lightGray = CommonViewModel(textColor: .appTextDark, backgrounColor: .appLightGray)
    static let darkGray = CommonViewModel(textColor: .appTextLight, backgrounColor: .appTextDark)
}


// MARK: - CommonTextView

struct CommonTextView: View {
    let text: String
    let model: CommonViewModel

    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(model.textColor)
                .padding()
        }.background(
            RoundedRectangle(cornerRadius: 8)
                .fill(model.backgrounColor)
        )
        .padding()
    }
}

// MARK: - Previews

struct CommonView_Previews: PreviewProvider {
    static let theme = Theme()
    static let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    static var previews: some View {
        Group {
            VStack {
                CommonTextView(text: text, model: .primary)
                CommonTextView(text: text, model: .secondary)
            }
            .background(theme.appBackground)

            VStack {
                CommonTextView(text: text, model: .tirtiary)
                CommonTextView(text: text, model: .quaternary)
            }.background(theme.appBackground)

            VStack {
                CommonTextView(text: text, model: .quinary)
                CommonTextView(text: text, model: .lightGray)
            }.background(theme.appBackground)

            VStack {
                CommonTextView(text: text, model: .darkGray)
            }.background(theme.appBackground)
        }
    }
}
