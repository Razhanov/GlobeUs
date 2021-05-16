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
    func signInGoogle(userId: String)
    func signInApple(userId: String)
    func signInFacebook(userId: String)
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
        AuthService.login(email: email, password: password) { responce in
            switch responce {
            case .success(let result):
                print(result.data.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInGoogle(userId: String) {
        AuthService.signInGoogle(userId: userId) { responce in
            switch responce {
            case .success(let result):
                print(result.data.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInApple(userId: String) {
        AuthService.signInApple(userId: userId) { responce in
            switch responce {
            case .success(let result):
                print(result.data.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signInFacebook(userId: String) {
        AuthService.signInFacebook(userId: userId) { responce in
            switch responce {
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
