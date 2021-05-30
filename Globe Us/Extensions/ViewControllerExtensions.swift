//
//  ViewControllerExtensions.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import Foundation
import UIKit

extension UIViewController {
    //    func addCloseButton() {
    //        let closeButton = CloseButton()
    //        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    //    }
    
    @objc func closeTapped() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func setNavigationBarTitle(
        _ title: String,
        backgroundColor: UIColor = .systemBackground,
        preferredLargeTitle: Bool = false,
        tintColor: UIColor = .label,
        titleColor: UIColor = .label,
        removeSeparator: Bool = true) {
        navigationItem.title = title
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.shadowColor = removeSeparator ? .clear : .quaternaryLabel
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
    }
    
    func addVC(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeVC() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showConfirmDeleteAlert(success: @escaping () -> ()) {
        let alert = UIAlertController(title: "Удаление", message: "Вы уверены, что хотите удалить объект?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            success()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
