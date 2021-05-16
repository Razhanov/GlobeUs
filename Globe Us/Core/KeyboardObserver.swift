//
//  KeyboardObserver.swift
//  Globe Us
//
//  Created by Михаил Беленко on 11.05.2021.
//

import UIKit

final class KeyboardObserver {
    
    var isSuspended: Bool = false
    
    var lastKnownKeyboardSize: CGSize? {
        return KeyboardObserver.lastKnownKeyboardSize
    }
    
    private static var lastKnownKeyboardSize: CGSize?
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardFrameWillChange),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    var onKeyboardWillShow: ((CGRect, Double) -> Void)?
    var onKeyboardWillHide: ((CGRect, Double) -> Void)?
    var onKeyboardFrameWillChange: ((CGRect, Double) -> Void)?
    
    private(set) var isKeyboardShown: Bool = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard !self.isKeyboardShown, !self.isSuspended else { return }
        self.isKeyboardShown = true
        guard let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        let keyboardFrame = frameValue.cgRectValue
        KeyboardObserver.lastKnownKeyboardSize = keyboardFrame.size
        self.onKeyboardWillShow?(keyboardFrame, animationDuration)
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        guard self.isKeyboardShown, !self.isSuspended else { return }
        self.isKeyboardShown = false
        guard let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        let keyboardFrame = frameValue.cgRectValue
        self.onKeyboardWillHide?(keyboardFrame, animationDuration)
    }
    
    @objc
    private func keyboardFrameWillChange(_ notification: Notification) {
        guard self.isKeyboardShown, !self.isSuspended else { return }
        guard let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        let keyboardFrame = frameValue.cgRectValue
        KeyboardObserver.lastKnownKeyboardSize = keyboardFrame.size
        self.onKeyboardFrameWillChange?(keyboardFrame, animationDuration)
    }
}

