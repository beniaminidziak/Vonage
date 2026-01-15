//
//  PreviewView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import SwiftUI

struct PreviewView: View {
    let view: UIView?

    var body: some View {
        content
            .frame(width: 110, height: 180)
            .background(Color.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
            .padding(16)
    }

    @ViewBuilder
    private var content: some View {
        if let view {
            FlexibleView(view: view)
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        Image(systemName: "person.fill")
            .font(.system(size: 30))
            .foregroundColor(.blue)
    }
}
