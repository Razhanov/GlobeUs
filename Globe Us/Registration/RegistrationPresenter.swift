//
//  RegistrationPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 16.05.2021.
//

import Foundation
import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func setView()
}

protocol RegistrationPresenter {
    func viewDidLoad()
    func register(email: String, password: String)
    func signInWithGoogle(userId: String)
    func signInWithApple(userId: String)
    func signInWithFacebook(userId: String)
    func openLogin()
}

class RegistrationPresenterImplementation : RegistrationPresenter {
    
    fileprivate weak var view: RegistrationViewProtocol?
    weak var loginView: AuthorizationViewProtocol?
    weak var mainCoordinator: MainCoordinator?
    
    init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setView()
    }
    
    func register(email: String, password: String) {
        AuthService.register(email: email, password: password) { [weak self] response in
            switch response {
            case .success(let result):
                self?.loginView?.setEmail(email: result.data.email)
                self?.openLogin()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInWithGoogle(userId: String) {
        AuthService.signInWithGoogle(userId: userId) { [weak self] response in
            switch response {
            case .success(let result):
                AuthService.setAccessToken(result.data.accessToken)
                self?.mainCoordinator?.openProfile()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInWithApple(userId: String) {
        AuthService.signInWithApple(userId: userId) { [weak self] response in
            switch response {
            case .success(let result):
                AuthService.setAccessToken(result.data.accessToken)
                self?.mainCoordinator?.openProfile()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInWithFacebook(userId: String) {
        AuthService.signInWithFacebook(userId: userId) { [weak self] response in
            switch response {
            case .success(let result):
                AuthService.setAccessToken(result.data.accessToken)
                self?.mainCoordinator?.openProfile()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func openLogin() {
        mainCoordinator?.openPreviousViewController()
    }
}
