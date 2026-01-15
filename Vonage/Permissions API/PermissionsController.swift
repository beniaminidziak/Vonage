//
//  PermissionsController.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

protocol PermissionsController {
    func request(_ media: Media) async -> Bool
    func status(_ media: Media) -> Bool
}
