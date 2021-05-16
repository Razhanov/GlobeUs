//
//  RegistrationPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 16.05.2021.
//

import Foundation
import UIKit

protocol RegistrationViewProtocol: class {
    func setView()
}

protocol RegistrationPresenter {
    func viewDidLoad()
    func register(email: String, password: String)
    func signInGoogle(userId: String)
    func signInApple(userId: String)
    func signInFacebook(userId: String)
    func openLogin()
}

class RegistrationPresenterImplementation : RegistrationPresenter {
    
    fileprivate weak var view: RegistrationViewProtocol?
    weak var loginView: AuthorizationViewProtocol?
    weak var navigationController: UINavigationController?
    
    init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setView()
    }
    
    func register(email: String, password: String) {
        AuthService.register(email: email, password: password) { [weak self] responce in
            switch responce {
            case .success(let result):
                self?.loginView?.setEmail(email: result.data.email)
                self?.openLogin()
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
    
    func openLogin() {
        navigationController?.popViewController(animated: true)
    }
}
