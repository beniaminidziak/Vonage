//
//  SceneDelegate.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private lazy var navigationController = UINavigationController(
        rootViewController: UIHostingController(
            rootView: HomeView(action: presentPermissionsViewController)
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
}
