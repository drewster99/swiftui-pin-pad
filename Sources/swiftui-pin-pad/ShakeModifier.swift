//
//  ShakeModifier.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

internal extension View {
    /// Shake the view horizontally when `trigger` transitions to `true`.
    /// `onCompletion` is called when animation is finished
    func shake(trigger: Binding<Bool>, onCompletion: (() -> Void)? = nil) -> some View {
        self
            .modifier(ShakeModifier(shake: trigger, onCompletion: onCompletion))
    }
}

/// `ShakeModifier` just allows us to use a `Bool` to start the shake
internal struct ShakeModifier: ViewModifier {
    /// Set to `true` to animate
    @Binding var shake: Bool

    /// Called when animation completes
    var onCompletion: (() -> Void)?

    @State private var offset: CGFloat = 0.0

    func body(content: Content) -> some View {
        content
            .modifier(ShakeEffect(animatableData: offset))
            .onChange(of: shake) { _, newValue in
                if newValue {
                    withAnimation(.default) {
                        offset = 2.0
                    } completion: {
                        offset = 0.0
                        shake = false
                        onCompletion?()
                    }
                }
            }
    }
}

internal struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat // This will be the "shake count" or intensity

    func effectValue(size: CGSize) -> ProjectionTransform {
        // Apply an offset based on the animatableData
        let offset = sin(animatableData * .pi * 2) * 15 // Adjust 10 for shake intensity
        return ProjectionTransform(CGAffineTransform(translationX: offset, y: 0))
    }
}
