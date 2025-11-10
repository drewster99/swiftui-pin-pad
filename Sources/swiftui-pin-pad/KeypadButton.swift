//
//  KeypadButton.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

internal struct KeypadButton: View {
    let content: ButtonContent
    @Environment(\.onButtonPress) var onButtonPress: (ButtonContent) -> Void

    init(_ content: ButtonContent) {
        self.content = content
    }

    private var buttonStyle: some PrimitiveButtonStyle  {
        if #available(iOS 26.0, macOS 26.0, *) {
            return .glass
        } else {
            return .bordered
        }
    }

    var body: some View {
        Button(action: {
            onButtonPress(content)
        }, label: {
            ZStack(alignment: .center) {
                // placeholder for spacing
                FormattedKeypadButtonContent(.nine)
                    .pinPadIncludesButtonLetters(true)
                    .hidden()

                // actual content
                FormattedKeypadButtonContent(content)
            }
            .contentShape(Rectangle())
        })
        .keyboardShortcut(content.keyboardShortcut)
        .buttonStyle(buttonStyle)
        .buttonBorderShape(.circle)
    }
}

internal extension EnvironmentValues {
    @Entry var onButtonPress: (ButtonContent) -> Void = { _ in }
}
