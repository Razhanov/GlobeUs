//
//  RegistrationConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 16.05.2021.
//

import UIKit

protocol RegistrationConfigurator {
    func configure(viewController: RegistrationViewController, loginView: AuthorizationViewProtocol?, mainCoordinator: MainCoordinator?)
}

class RegistrationConfiguratorImplementation : RegistrationConfigurator {
    func configure(viewController: RegistrationViewController, loginView: AuthorizationViewProtocol? = nil, mainCoordinator: MainCoordinator?) {
        let presenter = RegistrationPresenterImplementation(view: viewController)
        presenter.mainCoordinator = mainCoordinator
        presenter.loginView = loginView
        viewController.presenter = presenter
    }
}
