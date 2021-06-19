//
//  ChangePasswordView.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import UIKit

final class ChangePasswordView: UIView {
    private var showOldPassword: Bool = false {
        didSet {
            visibilityOldPasswordButton.setImage(UIImage(iconNamed: showOldPassword ? .eyeVisibilityOn : .eyeVisibilityOff), for: .normal)
            oldPasswordTextField.isSecureTextEntry = !showOldPassword
        }
    }
    
    private var showNewPassword: Bool = false {
        didSet {
            visibilityNewPasswordButton.setImage(UIImage(iconNamed: showNewPassword ? .eyeVisibilityOn : .eyeVisibilityOff), for: .normal)
            newPasswordTextField.isSecureTextEntry = !showNewPassword
        }
    }
    
    private let visibilityButtonSize: CGSize = .init(width: 24, height: 24)
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private(set) lazy var oldPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Старый пароль"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var oldPasswordView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var oldPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor(colorNamed: .textColor)
        textField.placeholder = "Поле не может быть пустым"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private(set) lazy var visibilityOldPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .eyeVisibilityOff), for: .normal)
        button.tag = 0
        return button
    }()
    
    private(set) lazy var newPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Новый пароль"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var newPasswordView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor(colorNamed: .textColor)
        textField.placeholder = "Поле не может быть пустым"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private(set) lazy var visibilityNewPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .eyeVisibilityOff), for: .normal)
        button.tag = 1
        return button
    }()
    
    func changeVisibilityOldPassword() {
        showOldPassword.toggle()
    }
    
    func changeVisibilityNewPassword() {
        showNewPassword.toggle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initilizate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initilizate() {
        backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        
        scrollView.addSubview(oldPasswordLabel)
        scrollView.addSubview(oldPasswordView)
        oldPasswordView.addSubview(oldPasswordTextField)
        oldPasswordView.addSubview(visibilityOldPasswordButton)
        
        scrollView.addSubview(newPasswordLabel)
        scrollView.addSubview(newPasswordView)
        newPasswordView.addSubview(newPasswordTextField)
        newPasswordView.addSubview(visibilityNewPasswordButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        oldPasswordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        oldPasswordView.snp.makeConstraints { make in
            make.top.equalTo(oldPasswordLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        oldPasswordTextField.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        visibilityOldPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(oldPasswordTextField)
            make.leading.equalTo(oldPasswordTextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(visibilityButtonSize)
        }
        
        newPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(oldPasswordView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        newPasswordView.snp.makeConstraints { make in
            make.top.equalTo(newPasswordLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        visibilityNewPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(newPasswordTextField)
            make.leading.equalTo(newPasswordTextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(visibilityButtonSize)
        }
    }
}

extension ChangePasswordView {
    func keyboardWillShow(keyboardFrame: CGRect, animationDuration: Double) {
        let keyboardHeight = keyboardFrame.height - scrollView.safeAreaInsets.bottom

        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        let scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = scrollIndicatorInsets
    }

    func keyboardWillHide(keyboardFrame: CGRect, animationDuration: Double) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
