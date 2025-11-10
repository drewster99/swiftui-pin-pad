//
//  FormattedKeypadButtonContent.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

struct FormattedKeypadButtonContent<FormattedContent: View>: View {
    typealias KeypadButtonContentFormatter = (ButtonContent, Bool) -> FormattedContent
    let content: ButtonContent
    @Environment(\.pinPadIncludesButtonLetters) var pinPadIncludesButtonLetters: Bool
    @ViewBuilder let formattedContent: KeypadButtonContentFormatter

    init(_ content: ButtonContent, @ViewBuilder contentFormatter: @escaping KeypadButtonContentFormatter) {
        self.content = content
        self.formattedContent = contentFormatter
    }

    var body: some View {
        formattedContent(content, pinPadIncludesButtonLetters)
    }
}

extension FormattedKeypadButtonContent where FormattedContent == DefaultKeypadButtonFormattingView {
    init(_ content: ButtonContent) {
        self.init(content, contentFormatter: { content, pinPadIncludesButtonLetters in
            DefaultKeypadButtonFormattingView(content: content, pinPadIncludesButtonLetters: pinPadIncludesButtonLetters)
        })
    }
}

struct DefaultKeypadButtonFormattingView: View {
    let content: ButtonContent
    let pinPadIncludesButtonLetters: Bool

    let digitsFont: Font = .system(size: 36)
    let digitsWeight: Font.Weight = .semibold
    let lettersFont: Font = .system(size: 18)
    let lettersWeight = Font.Weight.medium

    var body: some View {
        VStack(alignment: .center) {
            Text(content.digit)
                .font(digitsFont)
                .fontWeight(digitsWeight)
            if pinPadIncludesButtonLetters {
                Text(content.subtitle)
                    .font(lettersFont)
                    .fontWeight(lettersWeight)
            }
        }
        .padding(8)
    }
}
