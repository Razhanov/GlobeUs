//
//  ProfileSettingsConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 30.05.2021.
//

import Foundation

protocol ProfileSettingsConfigurator {
    func configure(viewController: ProfileSettingsViewController)
}

final class ProfileSettingsConfiguratorImplementation : ProfileSettingsConfigurator {
    func configure(viewController: ProfileSettingsViewController) {
        let presenter = ProfileSettingsPresenterImplementation(view: viewController, navigationController: viewController.navigationController)
        viewController.presenter = presenter
    }
}
