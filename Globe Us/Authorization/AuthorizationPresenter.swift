//
//  AuthorizationPresenter.swift
//  Globe Us
//
//  Created by Karim Razhanov on 19.07.2020.
//

import Foundation
import UIKit

protocol AuthorizationViewProtocol: class {
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
    weak var navigationController: UINavigationController?
    
    init(view: AuthorizationViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setView()
    }
    
    func login(email: String, password: String) {
        AuthService.login(email: email, password: password) { response in
            switch response {
            case .success(let result):
                print(result.data.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInWithGoogle(userId: String) {
        AuthService.signInWithGoogle(userId: userId) { response in
            switch response {
            case .success(let result):
                print(result.data.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInWithApple(userId: String) {
        AuthService.signInWithApple(userId: userId) { response in
            switch response {
            case .success(let result):
                print(result.data.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInWithFacebook(userId: String) {
        AuthService.signInWithFacebook(userId: userId) { response in
            switch response {
            case .success(let result):
                print(result.data.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func openRegistration() {
        let registerVC = RegistrationViewController()
        registerVC.loginView = view
        
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
