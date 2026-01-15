//
//  VideoViewModel.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//


import Combine
import OpenTok

final class VideoViewModel: NSObject, ObservableObject {
    // Dictionary is not thread safe - `Safe` type with isolated actor allows safe subscriber storage
    private let subscribers = Safe<String, OTSubscriber>()
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
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {
        guard let subscriber = OTSubscriber(stream: stream, delegate: nil) else { return }
        var error: OTError?
        session.subscribe(subscriber, error: &error)
        if error != nil {
            // This doesn't need user facing handling - failure to subscription should ommit saving the reference
            return
        }
        Task { await subscribers.set(subscriber, for: stream.streamId) }
    }
    
    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
        Task {
            guard let subscriber = await subscribers.get(stream.streamId) else { return }
            var error: OTError?
            session.unsubscribe(subscriber, error: &error)
            if error != nil {
                // This doesn't need user facing handling - but subscriber should be retained if session decides it cannot unsubscribe from it yet
                return
            }
            Task { await subscribers.set(nil, for: stream.streamId) }
        }
    }
}
