//
//  StreamView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import SwiftUI

struct StreamView: View {
    let view: UIView?

    var body: some View {
        content.frame(maxWidth: .infinity, maxHeight: .infinity)
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
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 3)
                .frame(width: 80, height: 80)

            Image(systemName: "person.fill")
                .font(.system(size: 35))
                .foregroundColor(.gray)
        }
    }
}
