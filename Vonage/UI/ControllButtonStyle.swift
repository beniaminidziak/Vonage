//
//  ControllButtonStyle.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import SwiftUI

struct ControllButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color
    let highlightColor: Color

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle().fill(backgroundColor)
                .overlay(Circle().fill(configuration.isPressed ? highlightColor.opacity(0.2) : Color.clear))
            configuration.label
                .foregroundColor(foregroundColor)
        }
    }
}

extension ButtonStyle where Self == ControllButtonStyle {
    static var destructive: Self {
        Self(foregroundColor: .white, backgroundColor: .red, highlightColor: .black)
    }

    static var control: Self {
        Self(foregroundColor: .black, backgroundColor: .white, highlightColor: .white)
    }
}
