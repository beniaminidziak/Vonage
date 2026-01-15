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
    private var publisher: OTPublisher?
    private let controller: SessionController
    @Published private(set) var connectivity: Connectivity = .disconnected
    @Published private(set) var isVideoEnabled: Bool = true
    @Published private(set) var isAudioEnabled: Bool = true
    @Published private(set) var video: UIView?
    @Published private(set) var preview: UIView?

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

    func toggleAudio() {
        guard let publisher else { return }
        isAudioEnabled.toggle()
        publisher.publishAudio = isAudioEnabled
    }

    func toggleVideo() {
        guard let publisher else { return }
        isVideoEnabled.toggle()
        publisher.publishVideo = isVideoEnabled
    }
}

extension VideoViewModel: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
        connectivity = .connected
        createPublisher(session)
    }
    
    func sessionDidDisconnect(_ session: OTSession) {
        connectivity = .disconnected
        destroyPublisher(session)
    }
    
    func session(_ session: OTSession, didFailWithError error: OTError) {
        connectivity = .failed(error.localizedDescription)
    }
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {
        guard let subscriber = OTSubscriber(stream: stream, delegate: self) else { return }
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

    private func createPublisher(_ session: OTSession) {
        let settings = OTPublisherSettings()
        guard let publisher = OTPublisher(delegate: self, settings: settings) else { return }
        self.publisher = publisher
        // TODO: Publishing might fail but user might still be able to see subscribers - need some other way than full screen cover error view to display this kinds of errors
        session.publish(publisher, error: nil)
    }

    private func destroyPublisher(_ session: OTSession) {
        guard let publisher else { return }
        // Not sure if we should even remove it upon disconnection as documentation and examples are lacking information. Doing it for the sake of memory management but not handling error
        session.unpublish(publisher, error: nil)
        self.publisher = nil
    }
}

extension VideoViewModel: OTSubscriberDelegate {
    func subscriberDidConnect(toStream subscriber: OTSubscriberKit) {
        guard let subscriber = subscriber as? OTSubscriber else { return }
        video = subscriber.view
    }

    func subscriberDidReconnect(toStream subscriber: OTSubscriberKit) {
        guard let subscriber = subscriber as? OTSubscriber else { return }
        video = subscriber.view
    }

    func subscriberDidDisconnect(fromStream subscriber: OTSubscriberKit) {
        video = nil
    }

    func subscriberVideoEnabled(_ subscriber: OTSubscriberKit, reason: OTSubscriberVideoEventReason) {
        guard let subscriber = subscriber as? OTSubscriber else { return }
        video = subscriber.view
    }

    func subscriberVideoDisabled(_ subscriber: OTSubscriberKit, reason: OTSubscriberVideoEventReason) {
        video = nil
    }

    func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
        // This doens't need to be user facing error - would be nice to set up some logging for debugging
    }
}

extension VideoViewModel: OTPublisherDelegate {
    public func publisher(_ publisher: OTPublisherKit, streamCreated stream: OTStream) {
        guard let publisher = publisher as? OTPublisher else { return }
        isAudioEnabled = publisher.publishAudio
        isVideoEnabled = publisher.publishVideo
        preview = publisher.view
    }

    public func publisher(_ publisher: OTPublisherKit, streamDestroyed stream: OTStream) {
        self.preview = nil
    }

    public func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
        // This doens't need to be user facing error - would be nice to set up some logging for debugging
    }
}
