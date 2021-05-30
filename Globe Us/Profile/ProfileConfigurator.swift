//
//  ProfileConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import Foundation
import UIKit

protocol ProfileConfigurator {
    func configure(viewController: ProfileViewController)
}

final class ProfileConfiguratorImplementation : ProfileConfigurator {
    func configure(viewController: ProfileViewController) {
        let presenter = ProfilePresenterImplementation(view: viewController)
        viewController.presenter = presenter
    }
}
