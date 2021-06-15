//
//  SettingsConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import Foundation

protocol SettingsConfigurator {
    func configure(viewController: SettingsViewController)
}

final class SettingsConfiguratorImplementation : SettingsConfigurator {
    func configure(viewController: SettingsViewController) {
        let presenter = SettingsPresenterImplementation(view: viewController, navigationController: viewController.navigationController)
        viewController.presenter = presenter
    }
}
