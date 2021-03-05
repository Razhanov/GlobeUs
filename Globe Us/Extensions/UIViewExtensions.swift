//
//  UIViewExtensions.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import UIKit

extension UIView {

    /// Get the safe area layout of the device
    /// - Returns: The safe area layout
    func getSafeAreaInsets() -> UIEdgeInsets {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            return window.safeAreaInsets
        } else {
            return .zero
        }
    }
}
