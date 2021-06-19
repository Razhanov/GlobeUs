//
//  ProfileSettingsViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 30.05.2021.
//

import UIKit

final class ProfileSettingsViewController: UIViewController {
    var presenter: ProfileSettingsPresenter?
    
    private let keyboardObserver = KeyboardObserver()
    
    private lazy var mainView: ProfileSettingsView = {
        let view = ProfileSettingsView()
        
        view.genderButtonsStackView.arrangedSubviews.forEach { subview in
            if let button = subview as? UIButton {
                button.addTarget(self, action: #selector(changeGenderTapped), for: .touchUpInside)
            }
        }
        
        view.datePickerView.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        
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
        title = "Настройки профиля"
        
        let doneButton = UIButton()
        doneButton.setImage(UIImage(iconNamed: .doneIcon), for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    
    @objc private func backButtonClick() {
        presenter?.backAction()
    }
    
    @objc private func doneButtonClick() {
        guard let firstName = mainView.firstNameTextField.text,
              let lastName = mainView.lastNameTextField.text,
              let gender = mainView.genderButtonsStackView.arrangedSubviews.map({ $0 as? UIButton }).first(where: { $0?.isSelected ?? false })??.tag,
              let homeCity = mainView.homeCityTextField.text,
              let birthday = mainView.birthdayTextField.text else {
            return
        }
        
        presenter?.doneAction(firstName: firstName, lastName: lastName, gender: gender, homeCity: homeCity, birthday: birthday)
    }
    
    @objc private func changeGenderTapped(_ sender : UIButton){
        mainView.genderButtonsStackView.arrangedSubviews.forEach { subview in
            if let button = subview as? UIButton {
                button.isSelected = button.tag == sender.tag
            }
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        mainView.birthdayTextField.text = ProfileService.dateFormatter.string(from: sender.date)
    }
}

extension ProfileSettingsViewController: ProfileSettingsViewProtocol {
    func setData(_ data: ProfileResponse) {
        mainView.setData(data)
    }
}
