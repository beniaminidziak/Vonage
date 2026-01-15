//
//  AVPermissionsController.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import AVFoundation
import UIKit

final class AVPermissionsController: PermissionsController {
    func request(_ media: Media) async -> Bool {
        let media = map(media)
        return switch AVCaptureDevice.authorizationStatus(for: media) {
        case .authorized: true
        case .notDetermined: await AVCaptureDevice.requestAccess(for: media)
        case .denied, .restricted: settings()
        @unknown default: false
        }
    }

    func status(_ media: Media) -> Bool {
        AVCaptureDevice.authorizationStatus(for: map(media)) == .authorized
    }

    private func map(_ media: Media) -> AVMediaType {
        switch media {
        case .audio: .audio
        case .video: .video
        }
    }


    private func settings() -> Bool {
        // One of few examples of justified force unwrapping usage - might be encapsulated in helper and unit tested for extra safety
        let url = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(url)
        // Might persist at `false` - changing permission in settings forces application to restart
        return false
    }
}
