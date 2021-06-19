//
//  SettingsView.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import UIKit
import SnapKit

final class SettingsView: UIView {
    
    private var bottomViewConstraint: Constraint?
    
    private let selectCountryButtonSize = CGSize(width: 24, height: 24)
    private let citiesCollectionViewHeight: CGFloat = 116
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private(set) lazy var selectCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбор страны посещения"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var selectCountryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var selectCountryTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor(colorNamed: .textColor)
        textField.placeholder = "Нет доступных стран"
        textField.inputView = selectCountryPickerView
        return textField
    }()
    
    private(set) lazy var selectCountryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private(set) lazy var selectCountryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .expandMoreIcon), for: .normal)
        return button
    }()
    
    private(set) lazy var selectCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбор города посещения"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var selectCityButton: UIButton = {
        let button = UIButton()
        let title = NSAttributedString(string: "Показать все", attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(colorNamed: .mainColor)
        ])
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private(set) lazy var citiesCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private(set) lazy var citiesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: citiesCollectionViewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private(set) lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        return view
    }()
    
    private(set) lazy var selectMainScreenAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбор главного экрана приложения"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var selectMainScreenAppScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private(set) lazy var selectMainScreenAppButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    
    private(set) lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .visibilityOffIcon), for: .normal)
        let title = NSAttributedString(string: "Установить/изменить пароль", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(colorNamed: .textColor)
        ])
        button.setAttributedTitle(title, for: .normal)
        button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -14)
        return button
    }()
    
    private(set) lazy var changeLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .locationIcon), for: .normal)
        let title = NSAttributedString(string: "Изменить местоположение", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(colorNamed: .textColor)
        ])
        button.setAttributedTitle(title, for: .normal)
        button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -14)
        return button
    }()
    
    private(set) lazy var aboutAppButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .starIcon), for: .normal)
        let title = NSAttributedString(string: "О приложении", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(colorNamed: .textColor)
        ])
        button.setAttributedTitle(title, for: .normal)
        button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -20)
        return button
    }()
    
    private(set) lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .exitIcon), for: .normal)
        let title = NSAttributedString(string: "Выйти", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(colorNamed: .textColor)
        ])
        button.setAttributedTitle(title, for: .normal)
        button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -20)
        return button
    }()
    
    func bottomConstraintActive() {
        bottomViewConstraint?.isActive = bounds.height >= scrollView.contentSize.height
        layoutIfNeeded()
    }
    
    private func configureSelectMainScreenAppStackView() {
        MainScreenApp.allCases.forEach { screen in
            let button = RadioButton(title: screen.description)
            button.tag = screen.rawValue
            
            selectMainScreenAppButtonsStackView.addArrangedSubview(button)
        }
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
        
        scrollView.addSubview(selectCountryLabel)
        scrollView.addSubview(selectCountryView)
        selectCountryView.addSubview(selectCountryTextField)
        selectCountryView.addSubview(selectCountryButton)
        
        scrollView.addSubview(selectCityLabel)
        scrollView.addSubview(selectCityButton)
        scrollView.addSubview(citiesCollectionView)
        
        scrollView.addSubview(bottomView)
        
        bottomView.addSubview(selectMainScreenAppLabel)
        bottomView.addSubview(selectMainScreenAppScrollView)
        selectMainScreenAppScrollView.addSubview(selectMainScreenAppButtonsStackView)
        configureSelectMainScreenAppStackView()
        
        bottomView.addSubview(changePasswordButton)
        bottomView.addSubview(changeLocationButton)
        bottomView.addSubview(aboutAppButton)
        bottomView.addSubview(exitButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectCountryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        selectCountryView.snp.makeConstraints { make in
            make.top.equalTo(selectCountryLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        selectCountryTextField.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        selectCountryButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(selectCountryTextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(selectCountryButtonSize)
        }
        
        selectCityLabel.snp.makeConstraints { make in
            make.top.equalTo(selectCountryView.snp.bottom).offset(18)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        selectCityButton.snp.makeConstraints { make in
            make.firstBaseline.equalTo(selectCityLabel)
            make.leading.greaterThanOrEqualTo(selectCityLabel.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        citiesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectCityLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.greaterThanOrEqualTo(citiesCollectionViewHeight)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(citiesCollectionView.snp.bottom).offset(32)
            make.leading.trailing.equalTo(self)
            bottomViewConstraint = make.bottom.equalTo(self).priority(.high).constraint
            make.bottom.equalToSuperview()
        }
        
        selectMainScreenAppLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        selectMainScreenAppScrollView.snp.makeConstraints { make in
            make.top.equalTo(selectMainScreenAppLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        
        selectMainScreenAppButtonsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(selectMainScreenAppScrollView.snp.bottom).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide).inset(16)
        }
        
        changeLocationButton.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide).inset(16)
        }
        
        aboutAppButton.snp.makeConstraints { make in
            make.top.equalTo(changeLocationButton.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide).inset(16)
        }
        
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(aboutAppButton.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview().inset(24)
        }
    }
}

extension SettingsView {
    func keyboardWillShow(keyboardFrame: CGRect, animationDuration: Double) {
        if let bottomViewConstraint = bottomViewConstraint, bottomViewConstraint.isActive {
            bottomViewConstraint.deactivate()
            layoutIfNeeded()
        }
        
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
        
        if bounds.height >= scrollView.contentSize.height {
            bottomViewConstraint?.activate()
            layoutIfNeeded()
        }
    }
}
