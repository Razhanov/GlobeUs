//
//  AuthorizationConfigurator.swift
//  Globe Us
//
//  Created by Karim Razhanov on 19.07.2020.
//

import UIKit

protocol AuthorizationConfigurator {
    func configure(viewController: AuthorizationViewController, navigationController: UINavigationController?)
}

class AuthorizationConfiguratorImplementation : AuthorizationConfigurator {
    func configure(viewController: AuthorizationViewController, navigationController: UINavigationController? = nil) {
        let presenter = AuthorizationPresenterImplementation(view: viewController)
        presenter.navigationController = navigationController
        viewController.presenter = presenter
    }
}
