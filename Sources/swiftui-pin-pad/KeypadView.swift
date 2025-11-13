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
    let showCancelButton: Bool
    let onButtonPress: (ButtonContent) -> Void

    var body: some View {
        Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
            GridRow {
                KeypadButton(.one); KeypadButton(.two); KeypadButton(.three)
            }
            GridRow {
                KeypadButton(.four); KeypadButton(.five); KeypadButton(.six)
            }
            GridRow {
                KeypadButton(.seven)
                KeypadButton(.eight)
                KeypadButton(.nine)
            }
            GridRow {
                KeypadButton(.zero)
                    .gridCellColumns(3)
            }

            GridRow {
                Color.clear
                    .frame(height: 20)
                    .gridCellColumns(3)
                    .gridCellUnsizedAxes(.horizontal)
            }

            GridRow {
                HStack {
                    if showCancelButton {
                        // Cancel button
                        Button {
                            onButtonPress(.cancel)
                        } label: {
                            Text("Cancel")
                                .padding(5)
                                .contentShape(Rectangle())
                        }
                        .keyboardShortcut(ButtonContent.cancel.keyboardShortcut)
                        .buttonStyle(.borderless)
                    }
                    
                    Spacer()

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
                    .keyboardShortcut(ButtonContent.delete.keyboardShortcut)
                    .buttonStyle(.borderless)
                    .disabled(deleteDisabled)
                }
                .gridCellColumns(3)
                .gridCellUnsizedAxes(.horizontal)
            }
        }
        .environment(\.onButtonPress, onButtonPress)
    }
}
