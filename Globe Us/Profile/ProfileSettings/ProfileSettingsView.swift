//
//  ProfileSettingsView.swift
//  Globe Us
//
//  Created by Михаил Беленко on 30.05.2021.
//

import UIKit

final class ProfileSettingsView: UIView {
    
    private let photoImageViewSize: CGSize = .init(width: 110, height: 110)
    private let addPhotoButtonSize: CGSize = .init(width: 36, height: 36)
    private let homeCityButtonSize: CGSize = .init(width: 24, height: 24)
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = getCornerRadius(size: photoImageViewSize)
        return imageView
    }()
    
    private(set) lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .addPhotoIcon), for: .normal)
        button.backgroundColor = UIColor(colorNamed: .mainColor)
        button.layer.cornerRadius = getCornerRadius(size: addPhotoButtonSize)
        return button
    }()
    
    private(set) lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var firstNameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor(colorNamed: .textColor)
        textField.placeholder = "Имя не может быть пустым"
        return textField
    }()
    
    private(set) lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Фамилия"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var lastNameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor(colorNamed: .textColor)
        textField.placeholder = "Фамилия не может быть пустой"
        return textField
    }()
    
    private(set) lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Пол"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var genderScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private(set) lazy var genderButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    
    private(set) lazy var homeCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Родной город"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var homeCityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var homeCityTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor(colorNamed: .textColor)
        textField.placeholder = "Город не может быть пустым"
        return textField
    }()
    
    private(set) lazy var homeCityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .locationIcon), for: .normal)
        return button
    }()
    
    private(set) lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "День рождения"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var birthdayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorNamed: .mainSecondaryColor)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor(colorNamed: .textColor)
        textField.placeholder = "День рождения не может быть пустым"
        textField.inputView = datePickerView
        return textField
    }()
    
    private(set) lazy var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        return datePickerView
    }()
    
    func setData(_ data: ProfileResponse) {
        photoImageView.loadWithAlamofire(urlStringFull: data.photoURL)
        
        firstNameTextField.text = data.firstName
        lastNameTextField.text = data.lastName
        
        genderButtonsStackView.arrangedSubviews.forEach { subview in
            if let button = subview as? UIButton {
                button.isSelected = button.tag == data.gender.rawValue
            }
        }
        
        homeCityTextField.text = data.targetPlace
        birthdayTextField.text = ProfileService.dateFormatter.string(from: data.birthday)
        datePickerView.setDate(data.birthday, animated: true)
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
    
    private func getCornerRadius(size: CGSize) -> CGFloat {
        if size.width == size.height {
            return size.width / 2
        } else {
            return max(size.width, size.height) / 2
        }
    }
    
    private func configureGenderStackView() {
        Gender.allCases.forEach { gender in
            let button = RadioButton(title: gender.description)
            button.tag = gender.rawValue
            
            genderButtonsStackView.addArrangedSubview(button)
        }
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        
        scrollView.addSubview(photoImageView)
        scrollView.addSubview(addPhotoButton)
        
        scrollView.addSubview(firstNameLabel)
        scrollView.addSubview(firstNameView)
        firstNameView.addSubview(firstNameTextField)
        
        scrollView.addSubview(lastNameLabel)
        scrollView.addSubview(lastNameView)
        lastNameView.addSubview(lastNameTextField)
        
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderScrollView)
        genderScrollView.addSubview(genderButtonsStackView)
        configureGenderStackView()
        
        scrollView.addSubview(homeCityLabel)
        scrollView.addSubview(homeCityView)
        homeCityView.addSubview(homeCityTextField)
        homeCityView.addSubview(homeCityButton)
        
        scrollView.addSubview(birthdayLabel)
        scrollView.addSubview(birthdayView)
        birthdayView.addSubview(birthdayTextField)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(photoImageViewSize)
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.bottom.equalTo(photoImageView)
            make.centerX.equalTo(photoImageView.snp.trailing).offset(-8)
            make.size.equalTo(addPhotoButtonSize)
        }
        
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(18)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        firstNameView.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNameView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        lastNameView.snp.makeConstraints { make in
            make.top.equalTo(lastNameLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(lastNameView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        genderScrollView.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        
        genderButtonsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        homeCityLabel.snp.makeConstraints { make in
            make.top.equalTo(genderScrollView.snp.bottom).offset(21)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        homeCityView.snp.makeConstraints { make in
            make.top.equalTo(homeCityLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        homeCityTextField.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        homeCityButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(homeCityTextField.snp.trailing).offset(8)
            make.size.equalTo(homeCityButtonSize)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(homeCityView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        birthdayView.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview().inset(21)
        }
        
        birthdayTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}

extension ProfileSettingsView {
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
