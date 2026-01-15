//
//  VideoView.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//


import SwiftUI

struct VideoView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var model: VideoViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            content
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: model.connect)
    }

    @ViewBuilder
    private var content: some View {
        switch model.connectivity {
        case .connecting:
            connecting
        case .connected:
            ZStack(alignment: .bottom) {
                ZStack(alignment: .topTrailing) {
                    StreamView(view: model.video)
                    PreviewView(view: model.preview)
                }
                controls
            }
        case .disconnected:
            FarewellView(reconnect: model.connect)
        case let .failed(message):
            failed(message)
        }
    }

    private var connecting: some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
        }
    }

    private func failed(_ message: String) -> some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)

            Text("Operation Failed")
                .font(.title2)
                .foregroundColor(.white)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            VStack(spacing: 8) {
                Button(action: model.connect) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Try Again")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .cornerRadius(25)
                }

                Button { dismiss() } label: {
                    HStack {
                        Text("Leave")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(Color.red)
                    .cornerRadius(25)
                }
            }
        }
    }

    private var controls: some View {
        HStack(spacing: 8) {
            Spacer()
            Button(action: model.toggleAudio) {
                Image(systemName: model.isAudioEnabled ? "mic.fill" : "mic.slash.fill")
                    .font(.system(size: 22))
            }
            .frame(width: 56, height: 56)
            .buttonStyle(.control)
            Button(action: model.disconnect) {
                Image(systemName: "phone.fill")
                    .font(.system(size: 22))
            }
            .frame(width: 56, height: 56)
            .buttonStyle(.destructive)
            Button(action: model.toggleVideo) {
                Image(systemName: model.isVideoEnabled ? "video.fill" : "video.slash.fill")
            }
            .frame(width: 56, height: 56)
            .buttonStyle(.control)
            Spacer()
        }
    }
}
