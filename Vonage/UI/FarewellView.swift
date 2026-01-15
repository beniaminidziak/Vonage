//
//  FarewellView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//


import SwiftUI

struct FarewellView: View {
    var reconnect: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                Spacer()
                header
                VStack(spacing: 12) {
                    Text("You successfully disconnected from the call")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .accessibilityAddTraits(.isHeader)

                    Text("Thank you for your attention!")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                buttons
                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }

    private var header: some View {
        Image(systemName: "phone.down.fill")
            .font(.system(size: 64, weight: .medium))
            .foregroundStyle(.white)
            .frame(width: 120, height: 120)
            .background(
                Circle().fill(.red)
            )
    }

    private var buttons: some View {
        VStack(spacing: 8) {
            Button { dismiss() } label: {
                HStack {
                    Text("Leave")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(.ultraThinMaterial)
                .cornerRadius(25)
            }
            Button(action: reconnect) {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Reconnect")
                }
                .font(.headline)
                .foregroundColor(.green)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(.ultraThinMaterial)
                .cornerRadius(25)
            }
        }
    }
}

#Preview {
    FarewellView {}
}
