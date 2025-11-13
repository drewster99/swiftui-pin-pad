//
//  SwiftUIPINPad.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

/// Response type for PIN change callbacks
public enum PINChangeResponse {
    /// Clear the entered PIN
    case clearPIN
    /// Shake the PIN view to indicate invalid input
    case indicateInvalidPIN
    /// Take no action
    case doNothing
}

/// A customizable PIN entry pad with configurable length and callbacks
public struct SwiftUIPINPad<Title: View>: View {
    let requiredLength: Int
    let showCancelButton: Bool
    let title: Title
    let onPINChange: (String) -> PINChangeResponse
    let onPINComplete: (String) -> PINChangeResponse
    let onCancel: () -> Void

    /// The PIN string as currently entered
    @Binding private var pin: String

    /// PIN state used if no pin binding was provided in initializer call
    @State private var internalPIN: String

    /// Set to `true` when the password indication shakes to indicate wrong pin
    @State private var isShaking = false

    public var body: some View {
        VStack(spacing: 20) {
            title
            PINView(requiredLength: requiredLength, pinLength: pin.count)
                .shake(trigger: $isShaking) {
                    // onCompletion
                    pin.removeAll()
                }
            Spacer()
                .frame(height: 25)
            KeypadView(deleteDisabled: pin.isEmpty, showCancelButton: showCancelButton) { button in
                switch button {
                case .delete:
                    if pin.count > 0 {
                        _ = pin.removeLast()
                        handlePINChange(onPINChange(pin))
                    }
                case .cancel:
                    onCancel()

                default:
                    if pin.count < requiredLength {
                        pin += button.digit
                        handlePINChange(onPINChange(pin))
                        if pin.count == requiredLength {
                            handlePINChange(onPINComplete(pin))
                        }
                    }
                }

            }
            .disabled(isShaking)
        }
        .frame(minWidth: 350, idealWidth: 400, maxWidth: 500, minHeight: 775, idealHeight: 800, maxHeight: 825)
    }

    /// Creates a PIN pad view
    /// - Parameters:
    ///   - requiredLength: Number of digits required for PIN
    ///   - title: View displayed above the PIN indicator
    ///   - onPINChange: Called after each digit entry or deletion
    ///   - onPINComplete: Called when PIN reaches required length
    public init(requiredLength: Int = 4,
                showCancelButton: Bool = true,
                pin: Binding<String>? = nil,
                @ViewBuilder title: () -> Title,
                onPINChange: @escaping (String) -> PINChangeResponse = { _ in .doNothing },
                onPINComplete: @escaping (String) -> PINChangeResponse,
                onCancel: @escaping () -> Void = { }
    ) {
        self.requiredLength = requiredLength
        self.title = title()
        self.showCancelButton = showCancelButton
        self.onPINChange = onPINChange
        self.onPINComplete = onPINComplete
        self.onCancel = onCancel

        /// Only used if user doesn't provide us a binding for pin
        let internalPIN = State(initialValue: "")
        self._internalPIN = internalPIN
        if let pin {
            // Use the binding the user provided
            self._pin = pin
        } else {
            // Use our "internal" @State pin data
            self._pin = internalPIN.projectedValue
        }
    }

    private func shakePINView() {
        // will turn to false when animation completes
        isShaking = true
    }

    private func handlePINChange(_ response: PINChangeResponse) {
        switch response {
        case .clearPIN:
            pin.removeAll()
        case .doNothing:
            break
        case .indicateInvalidPIN:
            shakePINView()
        }
    }
}

#Preview {
    @Previewable @State var blah: String = ""

    VStack {
        SwiftUIPINPad {
            Text("Enter PIN")
                .font(.title)
                .fontWeight(.medium)
        } onPINChange: { pin in
            // optionally do something every time
            // something changes
            blah = "pin change \(pin)"
            return .doNothing
        } onPINComplete: { pin in
            guard pin == "1234" else {
                blah = "pin complete invalid pin"
                return .indicateInvalidPIN
            }
            // SUCCESSFUL!
            blah = "pin complete SUCCESS"
            return .doNothing
        } onCancel: {
            blah = "cancel"
        }
    }
}
