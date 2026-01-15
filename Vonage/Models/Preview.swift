//
//  Preview.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

import UIKit

enum Preview {
    case view(UIView)
    case failure(() -> Void)
    case placeholder
}
