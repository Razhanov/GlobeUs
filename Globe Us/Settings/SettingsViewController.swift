//
//  SettingsViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    var configurator = SettingsConfiguratorImplementation()
    var presenter: SettingsPresenter?
    
    private let keyboardObserver = KeyboardObserver()
    private var selectedRow: Int?
    private var countElementsCV: Int = 4
    
    private let cellReuseIdentifier = "SettingsCityCollectionViewCell"
    
    private lazy var mainView: SettingsView = {
        let view = SettingsView()
        
        view.selectCountryButton.addTarget(self, action: #selector(handleResponseSelectCountryPicker), for: .touchUpInside)
        
        view.selectMainScreenAppButtonsStackView.arrangedSubviews.forEach { subview in
            if let button = subview as? UIButton {
                button.addTarget(self, action: #selector(changeMainScreenAppTapped), for: .touchUpInside)
            }
        }
        
        view.citiesCollectionView.delegate = self
        view.citiesCollectionView.dataSource = self
        view.citiesCollectionView.register(SettingsCityCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkScreenOrientation()
        configureCountCollectionElements()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        configurator.configure(viewController: self)
        presenter?.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        checkScreenOrientation()
        configureCountCollectionElements()
    }
    
    private func configureCountCollectionElements() {
        DispatchQueue.main.async {
            guard let selectedRow = self.selectedRow, let count = self.presenter?.getCitiesCount(selectedCountryRow: selectedRow) else {
                self.countElementsCV = 0
                return
            }
            
            let possibleCount: Int = Int(self.mainView.citiesCollectionView.bounds.width) / 200
            let maxCountElements = possibleCount < 2 ? 4 : (possibleCount > 5 ? 10 : (possibleCount * 2))
            
            self.countElementsCV = count > maxCountElements ? maxCountElements : count
            
            self.mainView.citiesCollectionView.reloadData()
        }
    }
    
    private func checkScreenOrientation() {
        DispatchQueue.main.async {
            self.mainView.bottomConstraintActive()
        }
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
        title = "Настройки"
        
        let doneButton = UIButton()
        doneButton.setImage(UIImage(iconNamed: .doneIcon), for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    
    func configureSelectCountyPickerView(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .done, target: self, action: #selector(handleDoneSelectCountryPicker))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spacer, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputView = pickerView
        
        mainView.citiesCollectionView.reloadData()
    }
    
    @objc private func backButtonClick() {
        presenter?.backAction()
    }
    
    @objc private func doneButtonClick() {
        var selectedMainScreenRawValue: Int?
        mainView.selectMainScreenAppButtonsStackView.arrangedSubviews.forEach { subview in
            if let button = subview as? UIButton, button.isSelected {
                selectedMainScreenRawValue = button.tag
            }
        }
        
        if let selectedRow = selectedRow, let selectedMainScreenRawValue = selectedMainScreenRawValue {
            presenter?.doneAction(selectedCountryRow: selectedRow, mainScreenAppRawValue: selectedMainScreenRawValue)
        }
    }
    
    @objc func handleDoneSelectCountryPicker() {
        guard let row = selectedRow else {
            view.endEditing(true)
            return
        }
        mainView.selectCountryTextField.text = presenter?.getCountry(row: row)?.title
        configureCountCollectionElements()
        view.endEditing(true)
    }
    
    @objc func handleResponseSelectCountryPicker() {
        mainView.selectCountryTextField.becomeFirstResponder()
    }
    
    @objc private func changeMainScreenAppTapped(_ sender : UIButton){
        mainView.selectMainScreenAppButtonsStackView.arrangedSubviews.forEach { subview in
            if let button = subview as? UIButton {
                button.isSelected = button.tag == sender.tag
            }
        }
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setCountries() {
        configureSelectCountyPickerView(textField: mainView.selectCountryTextField)
        
        if presenter?.getCountriesCount() ?? 0 > 0 && mainView.selectCountryTextField.text?.isEmpty ?? true {
            mainView.selectCountryTextField.text = presenter?.getCountry(countryId: SettingsService.shared.settings.countryId)?.title
            if let selectedRow = presenter?.getCountryRow(countryId: SettingsService.shared.settings.countryId) {
                self.selectedRow = selectedRow
            }
            
            mainView.selectMainScreenAppButtonsStackView.arrangedSubviews.forEach { subview in
                if let button = subview as? UIButton {
                    button.isSelected = button.tag == SettingsService.shared.settings.mainScreenApp.rawValue
                }
            }
        }
    }
}

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let count = presenter?.getCountriesCount() else {
            return 0
        }
        
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter?.getCountry(row: row)?.title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
}

extension SettingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countElementsCV
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? SettingsCityCollectionViewCell else {
            let cell = SettingsCityCollectionViewCell()
            if let selectedRow = selectedRow {
                presenter?.configureCell(cell, row: indexPath.row, selectedCountryRow: selectedRow)
            }
            cell.delegate = self
            return cell
        }
        
        if let selectedRow = selectedRow {
            presenter?.configureCell(cell, row: indexPath.row, selectedCountryRow: selectedRow)
        }
        cell.delegate = self
        
        return cell
    }
}

extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let countElementInRow = CGFloat(countElementsCV / 2)
        let width: CGFloat = collectionViewWidth / countElementInRow - (12 * (countElementInRow - 1))
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
}

extension SettingsViewController: SettingsCityCollectionViewCellDelegate {
    func loadCity(_ city: City, completition: @escaping () -> ()) {
        presenter?.saveLoadedCity(countryId: city.countryId, cityId: city.id, completition: completition)
    }
}
