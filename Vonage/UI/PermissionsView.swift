//
//  PermissionsView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import SwiftUI

struct PermissionsView: View {
    @StateObject var model: PermissionsViewModel
    var action: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            header
            VStack(spacing: 8) {
                Row(icon: "mic.fill", title: "Microphone", isAuthorized: model.isAudioAuthorized, action: model.requestAudioAuthorization)
                Row(icon: "video.fill", title: "Camera", isAuthorized: model.isVideoAuthorized, action: model.requestVideoAuthorization)
            }
            Spacer()
            button

        }
        .padding(.horizontal, 32)
        .onAppear {
            model.checkAuthorizationStatus()
        }
    }

    private var header: some View {
        VStack(spacing: 16) {
            Image(systemName: "video.badge.checkmark")
                .font(.system(size: 56))
                .foregroundStyle(.primary)

            Text("Permissions Required")
                .font(.title2.bold())
                .foregroundStyle(.primary)

            Text("To make video calls, we need access to your camera and microphone.")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.7))
                .multilineTextAlignment(.center)
        }
    }

    private var button: some View {
        let isEnabled = model.isAudioAuthorized && model.isVideoAuthorized
        return Button(action: action) {
            HStack {
                Image(systemName: "phone.fill")
                Text("Join")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(isEnabled ? Color.green : .gray)
            .cornerRadius(25)
        }
        .disabled(!isEnabled)
    }

    private struct Row: View {
        let icon: String
        let title: String
        let isAuthorized: Bool
        let action: () -> Void

        var body: some View {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(.primary)
                    .frame(width: 32)
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)

                Spacer()
                status
            }
        }

        @ViewBuilder
        private var status: some View {
            if isAuthorized {
                Label("Granted", systemImage: "checkmark.circle.fill")
                    .font(.caption.bold())
                    .foregroundStyle(.green)
            } else {
                Button(action: action) {
                    Text("Allow")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(14)

                }
            }
        }
    }
}

// TODO: Preview if you have time to create dummy PermissionsController
