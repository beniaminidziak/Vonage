//
//  FlexibleView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import SwiftUI

struct FlexibleView: UIViewRepresentable {
    let view: UIView

    func makeUIView(context: Context) -> UIView {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
