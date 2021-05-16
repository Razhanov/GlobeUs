//
//  UIColorExtensions.swift
//  Globe Us
//
//  Created by Михаил Беленко on 11.05.2021.
//

import UIKit

enum ColorIdentifier: String {
    case mainColor = "main_color"
}

extension UIColor {
    convenience init(colorNamed colorIdentifier: ColorIdentifier) {
        self.init(named: colorIdentifier.rawValue)!
    }
}
