//
//  PreviewView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import SwiftUI

struct PreviewView: View {
    let preview: Preview

    var body: some View {
        content
            .frame(width: 110, height: 180)
            .background(Color.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
            .padding(16)
    }

    @ViewBuilder
    private var content: some View {
        switch preview {
        case let .view(view):
            FlexibleView(view: view)
        case let .failure(action):
            retry(action: action)
        case .placeholder:
            placeholder
        }
    }

    private func retry(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "repeat")
                .font(.system(size: 22))
        }
        .frame(width: 56, height: 56)
        .buttonStyle(.control)
    }

    private var placeholder: some View {
        Image(systemName: "person.fill")
            .font(.system(size: 30))
            .foregroundColor(.blue)
    }
}
