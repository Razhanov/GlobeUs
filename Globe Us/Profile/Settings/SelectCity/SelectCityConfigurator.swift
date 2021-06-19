//
//  SelectCityConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import UIKit

protocol SelectCityConfigurator {
    func configure(viewController: SelectCityViewController, mainCoordinator: MainCoordinator?, countryId: Int, cities: [City])
}

final class SelectCityConfiguratorImplementation : SelectCityConfigurator {
    func configure(viewController: SelectCityViewController, mainCoordinator: MainCoordinator?, countryId: Int, cities: [City]) {
        let presenter = SelectCityPresenterImplementation(view: viewController, countryId: countryId, cities: cities)
        presenter.mainCoordinator = mainCoordinator
        
        viewController.presenter = presenter
    }
}
