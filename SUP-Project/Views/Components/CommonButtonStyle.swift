//
//  CommonButtonStyle.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/14/22.
//

import SwiftUI

struct CommonButtonStyle: ButtonStyle {

    let foregroundColor: Color
    let backgroundColor: Color
    let isDisabled: Bool
    let hasBorder: Bool
    let padding: CGFloat

    var pad4: CommonButtonStyle {
        .init(foregroundColor: foregroundColor, backgroundColor: backgroundColor, isDisabled: isDisabled, hasBorder: hasBorder, padding: 4)
    }
    var pad8: CommonButtonStyle {
        .init(foregroundColor: foregroundColor, backgroundColor: backgroundColor, isDisabled: isDisabled, hasBorder: hasBorder, padding: 8)
    }

    var disabled: CommonButtonStyle {
        .init(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            isDisabled: true,
            hasBorder: hasBorder,
            padding: padding
        )
    }

    init(
        foregroundColor: Color,
        backgroundColor: Color = .clear,
        isDisabled: Bool = false,
        hasBorder: Bool = true,
        padding: CGFloat = 12)
    {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.isDisabled = isDisabled
        self.hasBorder = hasBorder
        self.padding = padding
    }

    func makeBody(configuration: Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed
            ? foregroundColor.opacity(0.3) : foregroundColor
        let currentBackgroundColor = isDisabled || configuration.isPressed ? backgroundColor.opacity(0.5) : backgroundColor

        return configuration.label
            .padding(padding)
            .foregroundColor(foregroundColor)
            .background(RoundedRectangle(cornerRadius: 6).fill(currentBackgroundColor))
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(currentForegroundColor, lineWidth: hasBorder ? 1 : 0)
            )
            .font(.system(.title3).bold())
    }


    static var `default` = CommonButtonStyle(foregroundColor: .white, backgroundColor: .appTextDark)
    static var primary = CommonButtonStyle(foregroundColor: .white, backgroundColor: .appSecondary)
    static var success = CommonButtonStyle(foregroundColor: .white, backgroundColor: Color(hex: 0x259B36))
    static var danger = CommonButtonStyle(foregroundColor: .white, backgroundColor: Color(hex: 0xD11F36))
    static var warning = CommonButtonStyle(foregroundColor: .black, backgroundColor: .appQuinary)
    static var info = CommonButtonStyle(foregroundColor: .white, backgroundColor: Color(hex: 0x1B91AA))
    static var light = CommonButtonStyle(foregroundColor: .black, backgroundColor: Color(hex: 0xDBE0E5))
    static var dark = CommonButtonStyle(foregroundColor: .white, backgroundColor: Color(hex: 0x272C31))
    static var link = CommonButtonStyle(foregroundColor: .appTirtiary, hasBorder: false)

}

struct CommonButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                button("Default button", style: .default)
                button("Default button", style: .default.disabled)
            }
            HStack {
                button("Primary button", style: .primary)
                button("Primary button", style: .primary.disabled)
            }
            HStack {
                button("Success button", style: .success)
                button("Success button", style: .success.disabled)
            }
            HStack {
                button("Danger button", style: .danger)
                button("Danger button", style: .danger.disabled)
            }
            HStack {
                button("Warning button", style: .warning)
                button("Warning button", style: .warning.disabled)
            }
            HStack {
                button("Info button", style: .info)
                button("Info button", style: .info.disabled)
            }
            HStack {
                button("Light button", style: .light)
                button("Light button", style: .light.disabled)
            }
            HStack {
                button("Default button", style: .default)
                button("Default button", style: .default.disabled)
            }
        }
        VStack {
            HStack {
                Button { } label: {
                    HStack {
                        Text("Cancel")
                        Image(systemName: CommonImageButton.Constants.errorButtonName)
                    }
                }
                .buttonStyle(CommonButtonStyle.danger)
                Button { } label: {
                    HStack {
                        Text("Cancel")
                        Image(systemName: CommonImageButton.Constants.errorButtonName)
                    }
                }
                .buttonStyle(CommonButtonStyle.danger.disabled)
            }
            HStack {
                button("Dark button", style: .dark)
                button("Dark button", style: .dark.disabled)
            }
            HStack {
                button("Link button", style: .link)
                button("Link button", style: .link.disabled)
            }
        }.padding()
    }

    static func button(_ text: String, style: CommonButtonStyle) -> some View {
        Button {

        } label: {
            Text(text)
        }
        .buttonStyle(style)
        .padding()
    }
}

