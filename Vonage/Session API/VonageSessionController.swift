//
//  VonageSessionController.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import OpenTok

final class VonageSessionController: SessionController {
    private let session: OTSession
    private let token: String

    init(session: OTSession, token: String) {
        self.session = session
        self.token = token
    }

    func connect() throws {
        var error: OTError?
        session.connect(withToken: token, error: &error)
        if let error { throw error }
    }

    func disconnect() throws {
        var error: OTError?
        session.disconnect(&error)
        if let error { throw error }
    }
}
