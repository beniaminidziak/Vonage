//
//  VideoViewModel.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//


import Combine
import OpenTok

final class VideoViewModel: NSObject, ObservableObject {
    private let controller: SessionController
    @Published private(set) var connectivity: Connectivity = .disconnected

    init(controller: SessionController) {
        self.controller = controller
    }

    func connect() {
        connectivity = .connecting
        do {
            try controller.connect()
        } catch {
            connectivity = .failed(error.localizedDescription)
        }
    }

    func disconnect() {
        try? controller.disconnect()
    }
}

extension VideoViewModel: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
        connectivity = .connected
    }
    
    func sessionDidDisconnect(_ session: OTSession) {
        connectivity = .disconnected
    }
    
    func session(_ session: OTSession, didFailWithError error: OTError) {
        connectivity = .failed(error.localizedDescription)
    }
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {}
    
    func session(_ session: OTSession, streamDestroyed stream: OTStream) {}
}
