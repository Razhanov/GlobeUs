//
//  ProfileConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import Foundation
import UIKit

protocol ProfileConfigurator {
    func configure(viewController: ProfileViewController, mainCoordinator: MainCoordinator?)
}

final class ProfileConfiguratorImplementation : ProfileConfigurator {
    func configure(viewController: ProfileViewController, mainCoordinator: MainCoordinator?) {
        let presenter = ProfilePresenterImplementation(view: viewController)
        presenter.viewController = viewController
        presenter.mainCoordinator = mainCoordinator
        
        viewController.presenter = presenter
    }
}
