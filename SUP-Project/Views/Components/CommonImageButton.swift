//
//  CommonImageButton.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/14/22.
//

import SwiftUI

struct CommonImageButton: View {
    let systemName: String
    let width: CGFloat
    let height: CGFloat
    let commonStyle: CommonButtonStyle
    let action: () -> Void

    init(systemName: String, size: CGFloat = 20, commonStyle: CommonButtonStyle = .default, action: @escaping () -> Void) {
        self.init(systemName: systemName, width: size, height: size, commonStyle: commonStyle, action: action)
    }

    init(systemName: String,
         width: CGFloat = 20,
         height: CGFloat = 20,
         commonStyle: CommonButtonStyle = .default,
         action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.width = width
        self.height = height
        self.commonStyle = commonStyle
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .frame(width: width, height: height, alignment: .center)
        }.buttonStyle(commonStyle)
    }

    static func downButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.downButtonName, size: size, commonStyle: .info.pad4, action: action)
    }

    static func upButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.upButtonName, size: size, commonStyle: .info.pad4, action: action)
    }

    static func searchButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.findButtonName, size: size, commonStyle: .info.pad4, action: action)
    }

    static func clearButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.xButtonName, size: size, commonStyle: .danger.pad4, action: action)
    }

    static func refreshButton(size: CGFloat = 44, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.refreshButtonName, size: size, commonStyle: .primary.pad8, action: action)
    }

    static func warningButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.warningButtonName, size: size, commonStyle: .warning.pad4, action: action)
    }

    static func errorButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.errorButtonName, size: size, commonStyle: .danger.pad8, action: action)
    }

    static func onButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.onImageName, size: size, commonStyle: .success.pad8, action: action)
    }

    static func offButton(size: CGFloat = 30, action: @escaping () -> Void) -> CommonImageButton {
        .init(systemName: Constants.offImageName, size: size, commonStyle: .danger.pad8, action: action)
    }

    struct Constants {
        static let downButtonName = "arrowtriangle.down.square.fill"
        static let upButtonName = "arrowtriangle.up.square.fill"
        static let xButtonName = "xmark.circle.fill"
        static let findButtonName = "magnifyingglass.circle.fill"
        static let refreshButtonName = "arrow.counterclockwise.circle.fill"
        static let warningButtonName = "exclamationmark.circle.fill"
        static let errorButtonName = "exclamationmark.octagon.fill"
        static let offImageName = "poweroff"
        static let onImageName = "power.circle"
    }
}

struct CommonImageButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                CommonImageButton.onButton { }
                CommonImageButton.offButton { }
            }.padding()
            VStack(spacing: 20) {
                CommonImageButton.downButton {}
                CommonImageButton.upButton {}
                CommonImageButton.searchButton {}
                CommonImageButton.clearButton {}
                CommonImageButton.refreshButton { }
                CommonImageButton.warningButton { }
                CommonImageButton.errorButton { }
            }.padding()
            VStack(spacing: 20) {
                CommonImageButton(systemName: CommonImageButton.Constants.downButtonName, size: 30, commonStyle: .warning.pad4, action: {})
                CommonImageButton(systemName: CommonImageButton.Constants.upButtonName, size: 34, commonStyle: .success.pad8, action: {})
                CommonImageButton(systemName: CommonImageButton.Constants.xButtonName, size: 38, commonStyle: .danger.pad8, action: {})
                CommonImageButton(systemName: CommonImageButton.Constants.findButtonName, size: 44, commonStyle: .primary.pad8, action: {})

            }.padding()
        }
    }
}

