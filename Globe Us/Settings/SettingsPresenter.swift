//
//  SettingsPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: AnyObject {
    func setCountries()
}

protocol SettingsPresenter {
    func viewDidLoad()
    func backAction()
    func doneAction(selectedCountryRow: Int, mainScreenAppRawValue: Int)
    func getCountriesCount() -> Int
    func getCitiesCount(selectedCountryRow: Int) -> Int?
    func getCountry(row: Int) -> CountryResponse?
    func getCountry(countryId: Int) -> CountryResponse?
    func getCountryRow(countryId: Int) -> Int?
    func configureCell(_ cell: SettingsCityCollectionViewCell, row: Int, selectedCountryRow: Int)
    func saveLoadedCity(countryId: Int, cityId: Int, completition: @escaping () -> ())
    func openAboutAppScreen()
}

final class SettingsPresenterImplementation: SettingsPresenter {
    
    fileprivate weak var view: SettingsViewProtocol?
    fileprivate weak var navigationController: UINavigationController?
    
    fileprivate var loadedCities: [Int: Set<Int>] = [:]
    
    private var countries: [CountryResponse]? {
        didSet {
            view?.setCountries()
        }
    }
    
    init(view: SettingsViewProtocol, navigationController: UINavigationController?) {
        self.view = view
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        loadCountries()
        configureLoadedCities()
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func doneAction(selectedCountryRow: Int, mainScreenAppRawValue: Int) {
        guard let countries = countries, selectedCountryRow < countries.count else {
            return
        }
        
        SettingsService.shared.applySettings(countryId: countries[selectedCountryRow].id, mainScreenAppRawValue: mainScreenAppRawValue)
        navigationController?.popViewController(animated: true)
    }
    
    func loadCountries() {
        CountriesService.getCountries(langId: 1) { [weak self] response in
            switch response {
            case .success(let result):
                self?.countries = result.data
            case .failure(let error):
                self?.backAction()
                print(error.localizedDescription)
            }
        }
    }
    
    func configureLoadedCities() {
        loadedCities.removeAll()
        
        SettingsService.shared.settings.loadedCitiesId.forEach { countryLoaded in
            loadedCities[countryLoaded.countryId] = Set(countryLoaded.loadedCitiesId)
        }
    }
    
    func getCountriesCount() -> Int {
        return countries?.count ?? 0
    }
    
    func getCitiesCount(selectedCountryRow: Int) -> Int? {
        guard let countries = countries, selectedCountryRow < countries.count else {
            return nil
        }
        
        return countries[selectedCountryRow].cities.count
    }
    
    func getCountry(row: Int) -> CountryResponse? {
        guard let countries = countries, row < countries.count else {
            return nil
        }
        
        return countries[row]
    }
    
    func getCountry(countryId: Int) -> CountryResponse? {
        countries?.first(where: { $0.id == countryId })
    }
    
    func getCountryRow(countryId: Int) -> Int? {
        countries?.firstIndex(where: { $0.id == countryId })
    }
    
    func configureCell(_ cell: SettingsCityCollectionViewCell, row: Int, selectedCountryRow: Int) {
        guard let countries = countries, selectedCountryRow < countries.count else {
            return
        }
        
        guard row < countries[selectedCountryRow].cities.count else {
            return
        }
        
        let city = countries[selectedCountryRow].cities[row]
        
        cell.setData(city: city, isLoad: loadedCities[city.countryId]?.contains(city.id) ?? false)
    }
    
    func saveLoadedCity(countryId: Int, cityId: Int, completition: @escaping () -> ()) {
        SettingsService.shared.loadCity(countryId: countryId, cityId: cityId)
        configureLoadedCities()
        
        completition()
    }
    
    func openAboutAppScreen() {
        let aboutAppVC = AboutAppViewController()
        
        navigationController?.pushViewController(aboutAppVC, animated: true)
    }
}
