//
//  TapticHelper.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import Foundation
import UIKit

public struct TapticHelper {
    
    public static let shared = TapticHelper()
    private init() { }
    
    /**
     Creates an error Taptic feedback
     */
    public func errorTaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    /**
     Creates a success Taptic feedback
     */
    public func successTaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    /**
     Creates a warning Taptic feedback
     */
    public func warningTaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    /**
     Creates a light Taptic feedback
     */
    public func lightTaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /**
     Creates a medium Taptic feedback
     */
    public func mediumTaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /**
     Creates a heavy Taptic feedback
     */
    public func heavyTaptic() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
}
