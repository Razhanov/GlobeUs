//
//  SettingsConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import Foundation

protocol SettingsConfigurator {
    func configure(viewController: SettingsViewController, mainCoordinator: MainCoordinator?)
}

final class SettingsConfiguratorImplementation : SettingsConfigurator {
    func configure(viewController: SettingsViewController, mainCoordinator: MainCoordinator?) {
        let presenter = SettingsPresenterImplementation(view: viewController)
        presenter.mainCoordinator = mainCoordinator
        
        viewController.presenter = presenter
    }
}
