//
//  ChangePasswordConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import Foundation

protocol ChangePasswordConfigurator {
    func configure(viewController: ChangePasswordViewController, mainCoordinator: MainCoordinator?)
}

final class ChangePasswordConfiguratorImplementation : ChangePasswordConfigurator {
    func configure(viewController: ChangePasswordViewController, mainCoordinator: MainCoordinator?) {
        let presenter = ChangePasswordPresenterImplementation(view: viewController)
        presenter.mainCoordinator = mainCoordinator
        
        viewController.presenter = presenter
    }
}
