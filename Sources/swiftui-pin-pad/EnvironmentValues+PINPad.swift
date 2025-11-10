//
//  EnvironmentValues+PINPad.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

public extension View {
    /// Show or hide letter subtitles on keypad buttons
    func pinPadIncludesButtonLetters(_ includeLetters: Bool) -> some View {
        modifier(
            PinPadIncludesButtonLettersViewModifier(pinPadIncludesButtonLetters: includeLetters)
        )
    }

    /// Set the spacing between keypad buttons
    func pinPadButtonSpacing(_ spacing: CGFloat) -> some View {
        modifier(
            PinPadsButtonSpacingViewModifier(spacing: spacing)
        )
    }
}

internal extension EnvironmentValues {
    @Entry var pinPadIncludesButtonLetters: Bool = true
    @Entry var pinPadButtonSpacing: CGFloat = 24.0
}

internal struct PinPadIncludesButtonLettersViewModifier: ViewModifier {
    let pinPadIncludesButtonLetters: Bool

    func body(content: Content) -> some View {
        content
            .environment(\.pinPadIncludesButtonLetters, pinPadIncludesButtonLetters)
    }
}

internal struct PinPadsButtonSpacingViewModifier: ViewModifier {
    let spacing: CGFloat

    func body(content: Content) -> some View {
        content
            .environment(\.pinPadButtonSpacing, spacing)
    }
}
