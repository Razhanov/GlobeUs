//
//  Coordinator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func openPreviousViewController()
}

extension Coordinator {
    func openPreviousViewController() {
        navigationController.popViewController(animated: true)
    }
}
