//
//  RegistrationView.swift
//  Globe Us
//
//  Created by Михаил Беленко on 16.05.2021.
//

import Foundation
import UIKit
import SnapKit
import AuthenticationServices
import GoogleSignIn

extension RegistrationView {
    private struct Strings {
        static let emailPlaceholder = "E-Mail"
        static let passwordPlaceholder = "Пароль"
        static let registerButtonTitle = "Зарегистрироваться"
        static let signInOtherLabelText = "или зайти через"
        static let firstPartTitleBottomButton = "Уже есть аккаунт? "
        static let secondPartTitleBottomButton = "Войти"
    }
}

class RegistrationView : UIView {
    
    private var bottomViewConstraint: Constraint?

    private(set) lazy var view: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private(set) lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(iconNamed: .logoWithTitle)
        return imageView
    }()
    
    private(set) lazy var emailView: UIView = {
        let textField = UIView()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(colorNamed: .mainColor).cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.emailPlaceholder
        return textField
    }()
    
    private(set) lazy var passwordView: UIView = {
        let textField = UIView()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(colorNamed: .mainColor).cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.passwordPlaceholder
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private(set) lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.registerButtonTitle, for: .normal)
        button.setTitleColor(UIColor(colorNamed: .mainColor), for: .normal)
        button.backgroundColor = UIColor(colorNamed: .mainColor).withAlphaComponent(0.2)
        return button
    }()
    
    private(set) lazy var bottomView: UIView = {
        let button = UIView()
        button.backgroundColor = UIColor(colorNamed: .mainColor)
        return button
    }()
    
    private(set) lazy var signInWithGoogleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        return button
    }()
    
    private(set) lazy var signInWithAppleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        return button
    }()
    
    private(set) lazy var signInOtherLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.signInOtherLabelText
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var signInWithVKButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .signInWithVKIcon), for: .normal)
        return button
    }()
    
    private(set) lazy var signInWithFacebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .signInWithFacebookIcon), for: .normal)
        return button
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(getAttributedTitleForLoginButtonButton(), for: .normal)
        return button
    }()
    
    private func getAttributedTitleForLoginButtonButton() -> NSAttributedString {
        let firstPart = NSMutableAttributedString(string: Strings.firstPartTitleBottomButton, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        let secondPart = NSAttributedString(string: Strings.secondPartTitleBottomButton, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        firstPart.append(secondPart)
        
        return firstPart
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(view)
        view.addSubview(iconImageView)
        emailView.addSubview(emailTextField)
        view.addSubview(emailView)
        passwordView.addSubview(passwordTextField)
        view.addSubview(passwordView)
        view.addSubview(registerButton)
        
        view.addSubview(bottomView)
        bottomView.addSubview(signInWithGoogleButton)
        bottomView.addSubview(signInWithAppleButton)
        bottomView.addSubview(signInOtherLabel)
        bottomView.addSubview(signInWithVKButton)
        bottomView.addSubview(signInWithFacebookButton)
        bottomView.addSubview(loginButton)
    }
    
    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        emailView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(iconImageView.snp.bottom).offset(48)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(48)
        }
        emailTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(48)
        }
        passwordTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(48)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            bottomViewConstraint = make.bottom.equalTo(safeAreaLayoutGuide).priority(.high).constraint
            make.bottom.equalToSuperview()
        }
        
        signInWithGoogleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 196, height: 40))
        }
        
        signInWithAppleButton.snp.makeConstraints { make in
            make.top.equalTo(signInWithGoogleButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 196, height: 40))
        }
        
        signInOtherLabel.snp.makeConstraints { make in
            make.top.equalTo(signInWithAppleButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        signInWithVKButton.snp.makeConstraints { make in
            make.top.equalTo(signInOtherLabel.snp.bottom).offset(4)
            make.trailing.equalTo(bottomView.snp.centerX).offset(-8)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        
        signInWithFacebookButton.snp.makeConstraints { make in
            make.top.equalTo(signInOtherLabel.snp.bottom).offset(4)
            make.leading.equalTo(bottomView.snp.centerX).offset(8)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(signInWithVKButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
        
        bottomViewConstraint?.activate()
    }
}

extension RegistrationView {
    func keyboardWillShow(keyboardFrame: CGRect, animationDuration: Double) {
        bottomViewConstraint?.deactivate()
        
        let keyboardHeight = keyboardFrame.height - view.safeAreaInsets.bottom

        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        let scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

        view.contentInset = contentInsets
        view.scrollIndicatorInsets = scrollIndicatorInsets
    }

    func keyboardWillHide(keyboardFrame: CGRect, animationDuration: Double) {
        bottomViewConstraint?.activate()
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.contentInset = contentInsets
        view.scrollIndicatorInsets = contentInsets
    }
}
