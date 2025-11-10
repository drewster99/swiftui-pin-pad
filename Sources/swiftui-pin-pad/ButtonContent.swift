//
//  ButtonContent.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

/// Represents the content of a keypad button
public enum ButtonContent {
    /// Digit 1
    case one
    /// Digit 2 (ABC)
    case two
    /// Digit 3 (DEF)
    case three
    /// Digit 4 (GHI)
    case four
    /// Digit 5 (JKL)
    case five
    /// Digit 6 (MNO)
    case six
    /// Digit 7 (PQRS)
    case seven
    /// Digit 8 (TUV)
    case eight
    /// Digit 9 (WXYZ)
    case nine
    /// Digit 0
    case zero
    /// Delete button
    case delete

    var digit: String {
        switch self {
        case .one: "1"
        case .two: "2"
        case .three: "3"
        case .four: "4"
        case .five: "5"
        case .six: "6"
        case .seven: "7"
        case .eight: "8"
        case .nine: "9"
        case .zero: "0"
        case .delete: "Delete"
        }
    }

    var subtitle: String {
        switch self {
        case .one: ""
        case .two: "ABC"
        case .three: "DEF"
        case .four: "GHI"
        case .five: "JKL"
        case .six: "MNO"
        case .seven: "PQRS"
        case .eight: "TUV"
        case .nine: "WXYZ"
        case .zero: ""
        case .delete: ""
        }
    }

    var keyboardShortcut: KeyboardShortcut {
        switch self {
        case .delete: .init(.delete, modifiers: [])
        default: .init(KeyEquivalent(Character(digit)), modifiers: [])
        }
    }
}
