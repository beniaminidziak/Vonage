//
//  PermissionsViewModel.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import Combine

final class PermissionsViewModel: ObservableObject {
    private let controller: PermissionsController
    @Published var isVideoAuthorized: Bool = false
    @Published var isAudioAuthorized: Bool = false

    init(controller: PermissionsController) {
        self.controller = controller
    }

    func requestAudioAuthorization() {
        Task {
            isAudioAuthorized = await controller.request(.audio)
        }
    }

    func requestVideoAuthorization() {
        Task {
            isVideoAuthorized = await controller.request(.video)
        }
    }

    func checkAuthorizationStatus() {
        isVideoAuthorized = controller.status(.video)
        isAudioAuthorized = controller.status(.audio)
    }
}
