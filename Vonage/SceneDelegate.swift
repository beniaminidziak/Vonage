//
//  SceneDelegate.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let controller = UIViewController()
        controller.view.backgroundColor = .red
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
