//
//  PINView.swift
//  swiftui-pin-pad
//
//  Created by Andrew Benson on 11/7/25.
//

import SwiftUI

/// Displays little circles, either filled in or not, to represent the pin
internal struct PINView: View {
    let requiredLength: Int
    var pinLength: Int

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0 ..< requiredLength, id: \.self) { index in
                Image(systemName: pinLength > index ? "circle.fill" : "circle")
                    .imageScale(.large)
            }
        }
    }
}
