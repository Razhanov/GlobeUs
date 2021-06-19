//
//  AboutAppConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import Foundation

protocol AboutAppConfigurator {
    func configure(viewController: AboutAppViewController, mainCoordinator: MainCoordinator?)
}

final class AboutAppConfiguratorImplementation : AboutAppConfigurator {
    func configure(viewController: AboutAppViewController, mainCoordinator: MainCoordinator?) {
        let presenter = AboutAppPresenterImplementation(view: viewController)
        presenter.mainCoordinator = mainCoordinator
        
        viewController.presenter = presenter
    }
}
