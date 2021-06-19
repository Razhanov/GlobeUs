//
//  ProfileSettingsConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 30.05.2021.
//

import Foundation

protocol ProfileSettingsConfigurator {
    func configure(viewController: ProfileSettingsViewController, mainCoordinator: MainCoordinator?)
}

final class ProfileSettingsConfiguratorImplementation : ProfileSettingsConfigurator {
    func configure(viewController: ProfileSettingsViewController, mainCoordinator: MainCoordinator?) {
        let presenter = ProfileSettingsPresenterImplementation(view: viewController)
        presenter.mainCoordinator = mainCoordinator
        
        viewController.presenter = presenter
    }
}
