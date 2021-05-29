//
//  RegistrationConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 16.05.2021.
//

import UIKit

protocol RegistrationConfigurator {
    func configure(viewController: RegistrationViewController, loginView: AuthorizationViewProtocol?, navigationController: UINavigationController?)
}

class RegistrationConfiguratorImplementation : RegistrationConfigurator {
    func configure(viewController: RegistrationViewController, loginView: AuthorizationViewProtocol? = nil, navigationController: UINavigationController? = nil) {
        let presenter = RegistrationPresenterImplementation(view: viewController)
        presenter.navigationController = navigationController
        presenter.loginView = loginView
        viewController.presenter = presenter
    }
}
