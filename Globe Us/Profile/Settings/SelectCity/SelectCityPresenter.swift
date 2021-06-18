//
//  SelectCityPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import Foundation
import UIKit

protocol SelectCityViewProtocol: AnyObject {
    func setCities()
}

protocol SelectCityPresenter: LoadCityDelegate {
    func viewDidLoad()
    func backAction()
    func configureCell(_ cell: SelectCityTableViewCell, row: Int)
    func getCitiesCount() -> Int
    func getCity(row: Int) -> City?
}

final class SelectCityPresenterImplementation: SelectCityPresenter {
    
    fileprivate weak var view: SelectCityViewProtocol?
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let countryId: Int
    
    fileprivate var loadedCities: Set<Int> = []
    
    fileprivate var cities: [City] = [] {
        didSet {
            view?.setCities()
        }
    }
    
    init(view: SelectCityViewProtocol, navigationController: UINavigationController?, countryId: Int, cities: [City]) {
        self.view = view
        self.navigationController = navigationController
        self.countryId = countryId
        self.cities = cities
    }
    
    func viewDidLoad() {
        loadCities()
        configureLoadedCities()
    }
    
    private func loadCities() {
        CitiesService.getCities(countryId: countryId) { [weak self] response in
            switch response {
            case .success(let result):
                self?.cities = result.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureLoadedCities() {
        loadedCities.removeAll()
        
        if let countryLoaded = SettingsService.shared.settings.loadedCitiesId.first(where: { $0.countryId == countryId }) {
            loadedCities = Set(countryLoaded.loadedCitiesId)
        }
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureCell(_ cell: SelectCityTableViewCell, row: Int) {
        guard row < cities.count else {
            return
        }
        
        let city = cities[row]
        
        cell.setData(city: city, isLoad: loadedCities.contains(city.id))
    }

    
    func getCitiesCount() -> Int {
        cities.count
    }
    
    func getCity(row: Int) -> City? {
        guard row < cities.count else {
            return nil
        }
        
        return cities[row]
    }
    
    func loadCity(_ city: City, completition: () -> ()) {
        SettingsService.shared.loadCity(countryId: city.countryId, cityId: city.id)
        configureLoadedCities()
        
        completition()
    }
}
