//
//  MainCoordinator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import UIKit

protocol MainCoordinator: Coordinator {
    func openLogin()
    func openRegistration(loginView: AuthorizationViewProtocol?)
    func openProfile()
    func openProfileSettings()
    func openSettings()
    func openAboutApp()
    func openSelectCity(countryId: Int, cities: [City])
    func openChangePassword()
}

final class MainCoordinatorImplementation: MainCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let startVC: UIViewController!
        if AuthService.getToken() != nil {
            let profileVC = ProfileViewController()
            let configurator = ProfileConfiguratorImplementation()
            
            configurator.configure(viewController: profileVC, mainCoordinator: self)
            
            startVC = profileVC
        } else {
            let loginVC = AuthorizationViewController()
            let configurator = AuthorizationConfiguratorImplementation()
            
            configurator.configure(viewController: loginVC, mainCoordinator: self)
            
            startVC = loginVC
        }

        navigationController.setViewControllers([startVC], animated: true)
    }
    
    func openLogin() {
        let loginVC = AuthorizationViewController()
        let configurator = AuthorizationConfiguratorImplementation()
        
        configurator.configure(viewController: loginVC, mainCoordinator: self)
        
        navigationController.setViewControllers([loginVC], animated: true)
    }
    
    func openRegistration(loginView: AuthorizationViewProtocol?) {
        let registrationVC = RegistrationViewController()
        let configurator = RegistrationConfiguratorImplementation()
        
        configurator.configure(viewController: registrationVC, loginView: loginView, mainCoordinator: self)
        
        navigationController.pushViewController(registrationVC, animated: true)
    }
    
    func openProfile() {
        let profileVC = ProfileViewController()
        let configurator = ProfileConfiguratorImplementation()
        
        configurator.configure(viewController: profileVC, mainCoordinator: self)
        
        if navigationController.viewControllers.last is AuthorizationViewController || navigationController.viewControllers.last is RegistrationViewController {
            navigationController.setViewControllers([profileVC], animated: true)
        } else {
            navigationController.pushViewController(profileVC, animated: true)
        }
    }
    
    func openProfileSettings() {
        let profileSettingsVC = ProfileSettingsViewController()
        let configurator = ProfileSettingsConfiguratorImplementation()
        
        configurator.configure(viewController: profileSettingsVC, mainCoordinator: self)
        
        navigationController.pushViewController(profileSettingsVC, animated: true)
    }
    
    func openSettings() {
        let settingsVC = SettingsViewController()
        let configurator = SettingsConfiguratorImplementation()
        
        configurator.configure(viewController: settingsVC, mainCoordinator: self)
        
        navigationController.pushViewController(settingsVC, animated: true)
    }
    
    func openAboutApp() {
        let aboutAppVC = AboutAppViewController()
        let configurator = AboutAppConfiguratorImplementation()
        
        configurator.configure(viewController: aboutAppVC, mainCoordinator: self)
        
        navigationController.pushViewController(aboutAppVC, animated: true)
    }
    
    func openSelectCity(countryId: Int, cities: [City]) {
        let selectCityVC = SelectCityViewController()
        let configurator = SelectCityConfiguratorImplementation()
        
        configurator.configure(viewController: selectCityVC, mainCoordinator: self, countryId: countryId, cities: cities)
        
        
        navigationController.pushViewController(selectCityVC, animated: true)
    }
    
    func openChangePassword() {
        let changePasswordVC = ChangePasswordViewController()
        let configurator = ChangePasswordConfiguratorImplementation()
        
        configurator.configure(viewController: changePasswordVC, mainCoordinator: self)
        
        navigationController.pushViewController(changePasswordVC, animated: true)
    }
}
