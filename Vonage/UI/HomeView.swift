//
//  HomeView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import SwiftUI

struct HomeView: View {
    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "phone.fill")
                Text("Join")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(Color.green)
            .cornerRadius(25)
        }
    }
}

#Preview {
    HomeView {}
}
