//
//  SceneDelegate.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import OpenTok
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private lazy var navigationController = UINavigationController(
        rootViewController: UIHostingController(
            rootView: HomeView(action: presentVideoCallViewController)
        )
    )

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func presentPermissionsViewController() {
        let controller = AVPermissionsController()
        let model = PermissionsViewModel(controller: controller)
        let view = PermissionsView(model: model) {}

        navigationController.show(UIHostingController(rootView: view), sender: self)
    }

    private func presentVideoCallViewController() {
        // TODO: Might be handled more gracefully, but this is low priority due to problem not being user / software mistake, but wrong applicationID, sessionID and token assignments
        guard let session = OTSession(applicationId: "", sessionId: "", delegate: nil) else { return }
        let controller = VonageSessionController(session: session, token: "")
        let model = VideoViewModel(controller: controller)
        session.delegate = model

        navigationController.show(UIHostingController(rootView: VideoView(model: model)), sender: self)
    }
}
