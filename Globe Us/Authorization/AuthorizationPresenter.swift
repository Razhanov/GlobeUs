//
//  AuthorizationPresenter.swift
//  Globe Us
//
//  Created by Karim Razhanov on 19.07.2020.
//

import Foundation
import UIKit

protocol AuthorizationViewProtocol: AnyObject {
    func setView()
    func setEmail(email: String)
}

protocol AuthorizationPresenter {
    func viewDidLoad()
    func login(email: String, password: String)
    func signInWithGoogle(userId: String)
    func signInWithApple(userId: String)
    func signInWithFacebook(userId: String)
    func openRegistration()
}

class AuthorizationPresenterImplementation : AuthorizationPresenter {
    
    fileprivate weak var view: AuthorizationViewProtocol?
    weak var mainCoordinator: MainCoordinator?
    
    init(view: AuthorizationViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setView()
    }
    
    func login(email: String, password: String) {
        AuthService.login(email: email, password: password) { [weak self] response in
            switch response {
            case .success(let result):
                AuthService.setAccessToken(result.data.accessToken)
                self?.mainCoordinator?.openProfile()
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
    
    func openRegistration() {
        mainCoordinator?.openRegistration(loginView: view)
    }
}
