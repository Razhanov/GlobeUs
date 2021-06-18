//
//  SelectCityConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import UIKit

protocol SelectCityConfigurator {
    func configure(viewController: SelectCityViewController, navigationController: UINavigationController?, countryId: Int, cities: [City])
}

final class SelectCityConfiguratorImplementation : SelectCityConfigurator {
    func configure(viewController: SelectCityViewController, navigationController: UINavigationController?, countryId: Int, cities: [City]) {
        let presenter = SelectCityPresenterImplementation(view: viewController, navigationController: navigationController, countryId: countryId, cities: cities)
        viewController.presenter = presenter
    }
}
