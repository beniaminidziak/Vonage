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
        return switch status(media) {
        case .authorized: true
        case .pending: await AVCaptureDevice.requestAccess(for: media)
        case .unauthorized: settings()
        }
    }

    func status(_ media: Media) -> Authorization {
        status(map(media))
    }

    private func status(_ media: AVMediaType) -> Authorization {
        switch AVCaptureDevice.authorizationStatus(for: media) {
        case .notDetermined: .pending
        case .authorized: .authorized
        case .denied, .restricted: .unauthorized
        @unknown default: .unauthorized
        }
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
