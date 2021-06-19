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
    func collectionViewReloadData()
}

protocol SettingsPresenter: LoadCityDelegate {
    var selectedCountryId: Int? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func backAction()
    func doneAction(selectedCountryRow: Int, mainScreenAppRawValue: Int)
    func getCountriesCount() -> Int
    func getCitiesCount(selectedCountryRow: Int) -> Int?
    func getCountry(row: Int) -> CountryResponse?
    func getCountry(countryId: Int) -> CountryResponse?
    func getCountryRow(countryId: Int) -> Int?
    func configureCell(_ cell: SettingsCityCollectionViewCell, row: Int, selectedCountryRow: Int)
    func openAboutAppScreen()
    func openSelectCityScreen()
    func exit()
    func openChangePasswordScreen()
}

final class SettingsPresenterImplementation: SettingsPresenter {
    
    fileprivate weak var view: SettingsViewProtocol?
    weak var mainCoordinator: MainCoordinator?
    
    fileprivate var loadedCities: [Int: Set<Int>] = [:] {
        didSet {
            view?.collectionViewReloadData()
        }
    }
    var selectedCountryId: Int? = SettingsService.shared.settings.countryId
    
    private var countries: [CountryResponse]? {
        didSet {
            view?.setCountries()
        }
    }
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func viewWillAppear() {
        configureLoadedCities()
    }
    
    func viewDidLoad() {
        loadCountries()
        configureLoadedCities()
    }
    
    func backAction() {
        mainCoordinator?.openPreviousViewController()
    }
    
    func doneAction(selectedCountryRow: Int, mainScreenAppRawValue: Int) {
        guard let countries = countries, selectedCountryRow < countries.count else {
            return
        }
        
        SettingsService.shared.applySettings(countryId: countries[selectedCountryRow].id, mainScreenAppRawValue: mainScreenAppRawValue)
        mainCoordinator?.openPreviousViewController()
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
    
    func openAboutAppScreen() {
        mainCoordinator?.openAboutApp()
    }
    
    func openSelectCityScreen() {
        guard let country = countries?.first(where: { $0.id == selectedCountryId }) else {
            return
        }
        
        mainCoordinator?.openSelectCity(countryId: country.id, cities: country.cities)
    }
    
    func loadCity(_ city: City, completition: () -> ()) {
        SettingsService.shared.loadCity(countryId: city.countryId, cityId: city.id)
        configureLoadedCities()
        
        completition()
    }
    
    func exit() {
        AuthService.deleteToken()
        mainCoordinator?.openLogin()
    }
    
    func openChangePasswordScreen() {
        mainCoordinator?.openChangePassword()
    }
}
