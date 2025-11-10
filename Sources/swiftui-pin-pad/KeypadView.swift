//
//  KeypadView.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

internal struct KeypadView: View {
    @Environment(\.pinPadIncludesButtonLetters) var pinPadIncludesButtonLetters: Bool
    @Environment(\.pinPadButtonSpacing) var spacing: CGFloat
    var deleteDisabled: Bool
    let onButtonPress: (ButtonContent) -> Void

    var body: some View {
        VStack(alignment: .keypadTrailing) {
            Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
                GridRow {
                    KeypadButton(.one); KeypadButton(.two); KeypadButton(.three)
                }
                GridRow {
                    KeypadButton(.four); KeypadButton(.five); KeypadButton(.six)
                }
                GridRow {
                    KeypadButton(.seven); KeypadButton(.eight); KeypadButton(.nine)
                        .alignmentGuide(.keypadTrailing) { d in d[HorizontalAlignment.trailing] }
                }
                GridRow {
                    KeypadButton(.zero)
                        .gridCellColumns(3)
                }
            }

            Spacer()
                .frame(minHeight: 20, maxHeight: 40)

            // Delete button
            Button {
                onButtonPress(.delete)
            } label: {
                Label {
                    Text("Delete")
                } icon: {
                    Image(systemName: "delete.left")
                }
                .imageScale(.large)
                .padding(5)
                .contentShape(Rectangle())
            }
            .keyboardShortcut(.delete, modifiers: [])
            .padding(.bottom)
            .buttonStyle(.borderless)
            .alignmentGuide(.keypadTrailing) { d in d[HorizontalAlignment.trailing] }
            .disabled(deleteDisabled)
        }
        .environment(\.onButtonPress, onButtonPress)
    }
}

internal extension HorizontalAlignment {
    enum KeypadTrailingAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.trailing]
        }
    }

    static let keypadTrailing = HorizontalAlignment(KeypadTrailingAlignment.self)
}
