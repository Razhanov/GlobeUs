//
//  UIImageExtensions.swift
//  Globe Us
//
//  Created by Михаил Беленко on 11.05.2021.
//

import UIKit

enum IconIdentifier: String {
    case aboutDetail = "about_detail"
    case arrowLeft = "arrow_left"
    case arrowRight = "arrow_right"
    case backIcon = "back_icon"
    case capturePhoto = "capture_photo"
    case challengeInfo = "challenge_info"
    case demoImage = "demo_image"
    case focus = "focus"
    case group2080 = "Group 2080"
    case loc = "loc"
    case merge = "merge"
    case nav = "nav"
    case switchCamera = "switch_camera"
    case logoWithTitle = "logo_with_title"
    case signInApple = "sign_in_apple"
    case signInGoogle = "sign_in_google"
    case signInVK = "sign_in_vk"
    case signInFacebook = "sign_in_facebook"
}

extension UIImage {
    convenience init(iconNamed iconIdentifier: IconIdentifier) {
        self.init(named: iconIdentifier.rawValue)!
    }
}
