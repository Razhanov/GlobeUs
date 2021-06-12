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
    case signInWithAppleIcon = "sign_in_with_apple_icon"
    case signInWithGoogleIcon = "sign_in_with_google_icon"
    case signInWithVKIcon = "sign_in_with_vk_icon"
    case signInWithFacebookIcon = "sign_in_with_facebook_icon"
    case userSettingsIcon = "user_settings_icon"
    case settingsIcon = "settings_icon"
    case demoPhoto = "demo_photo"
    case photoCameraIcon = "photo_camera_icon"
    case stepIcon = "step_icon"
    case starIcon = "star_icon"
    case pinIcon = "pin_icon"
    case nextIcon = "next_icon"
    case bannerImage = "banner_image"
    case addPhotoIcon = "add_photo_icon"
    case backIconBlack = "back_icon_black"
    case doneIcon = "done_icon"
    case radioButtonSelect = "radio_button_select"
    case radioButtonUnselect = "radio_button_unselect"
    case locationIcon = "location_icon"
}

extension UIImage {
    convenience init(iconNamed iconIdentifier: IconIdentifier) {
        self.init(named: iconIdentifier.rawValue)!
    }
}
