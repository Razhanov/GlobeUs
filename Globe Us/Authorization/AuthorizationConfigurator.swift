//
//  AuthorizationConfigurator.swift
//  Globe Us
//
//  Created by Karim Razhanov on 19.07.2020.
//

import UIKit

protocol AuthorizationConfigurator {
    func configure(viewController: AuthorizationViewController, mainCoordinator: MainCoordinator?)
}

class AuthorizationConfiguratorImplementation : AuthorizationConfigurator {
    func configure(viewController: AuthorizationViewController, mainCoordinator: MainCoordinator?) {
        let presenter = AuthorizationPresenterImplementation(view: viewController)
        presenter.mainCoordinator = mainCoordinator
        viewController.presenter = presenter
    }
}
