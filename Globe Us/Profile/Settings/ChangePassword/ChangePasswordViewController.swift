//
//  ChangePasswordViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import UIKit

final class ChangePasswordViewController: UIViewController {
    var presenter: ChangePasswordPresenter?
    
    private let keyboardObserver = KeyboardObserver()
    
    private lazy var mainView: ChangePasswordView = {
        let view = ChangePasswordView()
        
        view.visibilityOldPasswordButton.addTarget(self, action: #selector(changeVisibilityButtonClick), for: .touchUpInside)
        view.visibilityNewPasswordButton.addTarget(self, action: #selector(changeVisibilityButtonClick), for: .touchUpInside)
        
        return view
    }()
    
    override func loadView() {
        view = mainView
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        presenter?.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    private func configureNavigationBar() {
        let backButton = UIButton()
        backButton.setImage(UIImage(iconNamed: .backIconBlack), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(colorNamed: .textColor),
            .font: UIFont.systemFont(ofSize: 18)
        ]
        title = "Изменить пароль"
        
        let doneButton = UIButton()
        doneButton.setImage(UIImage(iconNamed: .doneIcon), for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    
    @objc private func backButtonClick() {
        presenter?.backAction()
    }
    
    @objc private func doneButtonClick() {
        guard let oldPassword = mainView.oldPasswordTextField.text,
              let newPassword = mainView.newPasswordTextField.text else {
            return
        }
        
        presenter?.doneAction(oldPassword: oldPassword, newPassword: newPassword)
    }
    
    @objc private func changeVisibilityButtonClick(sender: UIButton) {
        if sender.tag == 0 {
            mainView.changeVisibilityOldPassword()
        }
        
        if sender.tag == 1 {
            mainView.changeVisibilityNewPassword()
        }
    }
}

extension ChangePasswordViewController: ChangePasswordViewProtocol {
}
