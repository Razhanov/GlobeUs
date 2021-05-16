//
//  RegistrationViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 16.05.2021.
//

import Foundation
import UIKit
import AuthenticationServices
import GoogleSignIn
import FBSDKLoginKit

class RegistrationViewController : UIViewController {
    
    var configurator = RegistrationConfiguratorImplementation()
    var presenter: RegistrationPresenter?
    weak var loginView: AuthorizationViewProtocol?
    
    private let keyboardObserver = KeyboardObserver()
    
    private(set) lazy var mainView: RegistrationView = {
        let view = RegistrationView()
        view.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        view.signInAppleButton.addTarget(self, action: #selector(clickSignInApple), for: .touchUpInside)
        view.signInVKButton.addTarget(self, action: #selector(clickSignInVK), for: .touchUpInside)
        view.signInFacebookButton.addTarget(self, action: #selector(clickSignInFacebook), for: .touchUpInside)
        view.loginButton.addTarget(self, action: #selector(openLogin), for: .touchUpInside)
        return view
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.keyboardObserver.onKeyboardWillShow = { [weak self] frame, animationDuration in
            self?.mainView.keyboardWillShow(keyboardFrame: frame, animationDuration: animationDuration)
        }
        
        self.keyboardObserver.onKeyboardWillHide = { [weak self] frame, animationDuration in
            self?.mainView.keyboardWillHide(keyboardFrame: frame, animationDuration: animationDuration)
        }
        
        self.keyboardObserver.onKeyboardFrameWillChange = { [weak self] frame, animationDuration in
            self?.mainView.keyboardWillShow(keyboardFrame: frame, animationDuration: animationDuration)
        }
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configurator.configure(viewController: self, loginView: loginView, navigationController: navigationController)
        presenter?.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @objc private func register() {
        guard let email = mainView.emailTextField.text,
              let password = mainView.passwordTextField.text else {
            return
        }
        
        presenter?.register(email: email, password: password)
    }
    
    @objc private func clickSignInApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc private func clickSignInVK() {
        print("clickSignInVK")
    }
    
    @objc private func clickSignInFacebook() {
        let loginManager = LoginManager()
        
        if let token = AccessToken.current {
            presenter?.signInFacebook(userId: token.userID)
        } else {
            loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    return
                }
                
                guard let result = result,
                      let token = result.token,
                      !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                
                self?.presenter?.signInFacebook(userId: token.userID)
            }
        }
    }
    
    @objc private func openLogin() {
        presenter?.openLogin()
    }
}

extension RegistrationViewController : RegistrationViewProtocol {
    func setView() {
        
    }
}

extension RegistrationViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            presenter?.signInApple(userId: appleIDCredential.user)
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension RegistrationViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        presenter?.signInGoogle(userId: user.userID)
        
    }
}
