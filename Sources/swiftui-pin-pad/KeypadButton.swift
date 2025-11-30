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

    private var requiresCompat: Bool {
        if #available(iOS 26.0, macOS 26.0, *) {
            let result = Bundle.main.object(forInfoDictionaryKey: "UIDesignRequiresCompatibility") as? Bool ?? false
            return result
        } else {
            return false
        }
    }

    var body: some View {
        if #available(iOS 26.0, macOS 26.0, *), !requiresCompat {
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
            .buttonStyle(.glass)
            .buttonBorderShape(.circle)
        } else {
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
            .buttonStyle(GentleBounceCircularOutlineButtonStyle())
        }
    }
}

/// A button style that looks a bit like the liquid glass version for
/// iOS 26 superficially but acts normal - for use under iPadOS 18
/// and iOS 26 in `UIDesignRequiresCompatibility` = `YES` mode.
///
/// Apple's `.glass` button style doesn't work right when `UIDesignRequiresCompatibility`
/// is `YES` and the app is running on iPadOS 26+.
struct GentleBounceCircularOutlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(.primary)      // regular text color
            .background(
                Circle()
                    .foregroundStyle(.background)
                    .shadow(color: .primary.opacity(configuration.isPressed ? 0.4 : 0.1), radius: 14.0, x: 2.5, y: 2.5)
            )
            .opacity(configuration.isPressed ? 0.3 : 1.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(
                .spring(response: 0.12, dampingFraction: 0.75),
                value: configuration.isPressed
            )
    }
}
internal extension EnvironmentValues {
    @Entry var onButtonPress: (ButtonContent) -> Void = { _ in }
}
