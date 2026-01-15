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

    private lazy var permissionsController = AVPermissionsController()
    private lazy var navigationController = UINavigationController(
        rootViewController: UIHostingController(
            rootView: HomeView(action: attemptVideoCallPresentation)
        )
    )

    private var isPreparedForVideoConversation: Bool {
        permissionsController.status(.audio) && permissionsController.status(.video)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func attemptVideoCallPresentation() {
        if isPreparedForVideoConversation {
            presentVideoCallViewController()
        } else {
            presentPermissionsViewController()
        }
    }

    private func presentPermissionsViewController() {
        let model = PermissionsViewModel(controller: permissionsController)
        let view = PermissionsView(model: model) { [weak self] in
            guard let self else { return }
            navigationController.popViewController(animated: false)
            presentVideoCallViewController()
        }

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
