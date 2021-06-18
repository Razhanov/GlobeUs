//
//  AboutAppConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import Foundation

protocol AboutAppConfigurator {
    func configure(viewController: AboutAppViewController)
}

final class AboutAppConfiguratorImplementation : AboutAppConfigurator {
    func configure(viewController: AboutAppViewController) {
        let presenter = AboutAppPresenterImplementation(view: viewController, navigationController: viewController.navigationController)
        viewController.presenter = presenter
    }
}
