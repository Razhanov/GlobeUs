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
    private var countElementsInRowCV: Int = 4
    
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
        
        view.aboutAppButton.addTarget(self, action: #selector(aboutAppButtonClick), for: .touchUpInside)
        view.selectCityButton.addTarget(self, action: #selector(showAllCitiesButtonClick), for: .touchUpInside)
        view.exitButton.addTarget(self, action: #selector(exitButtonClick), for: .touchUpInside)
        
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.keyboardObserver.onKeyboardWillShow = { [weak self] frame, animationDuration in
            self?.mainView.keyboardWillShow(keyboardFrame: frame, animationDuration: animationDuration)
            self?.configureCountCollectionElementsInRow()
        }
        
        self.keyboardObserver.onKeyboardWillHide = { [weak self] frame, animationDuration in
            self?.mainView.keyboardWillHide(keyboardFrame: frame, animationDuration: animationDuration)
            self?.configureCountCollectionElementsInRow()
        }
        
        self.keyboardObserver.onKeyboardFrameWillChange = { [weak self] frame, animationDuration in
            self?.mainView.keyboardWillShow(keyboardFrame: frame, animationDuration: animationDuration)
            self?.configureCountCollectionElementsInRow()
        }
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkScreenOrientation()
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        checkScreenOrientation()
    }
    
    private func configureCountCollectionElementsInRow() {
        DispatchQueue.main.async {
            guard let selectedRow = self.selectedRow, let count = self.presenter?.getCitiesCount(selectedCountryRow: selectedRow) else {
                self.countElementsInRowCV = 0
                return
            }
            
            let possibleCount: Int = Int(self.mainView.citiesCollectionView.bounds.width) / 200
            let maxCountElements = possibleCount < 2 ? 2 : (possibleCount > 5 ? 5 : possibleCount)
            
            self.countElementsInRowCV = count > maxCountElements ? maxCountElements : count
            
            self.mainView.citiesCollectionView.reloadData()
        }
    }
    
    private func checkScreenOrientation() {
        DispatchQueue.main.async {
            self.mainView.bottomConstraintActive()
            self.configureCountCollectionElementsInRow()
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
    
    func configureSelectCountyPickerView(textField: UITextField, pickerView: UIPickerView) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .done, target: self, action: #selector(handleDoneSelectCountryPicker))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spacer, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
        let country = presenter?.getCountry(row: row)
        mainView.selectCountryTextField.text = country?.title
        presenter?.selectedCountryId = country?.id
        configureCountCollectionElementsInRow()
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
    
    @objc func aboutAppButtonClick() {
        presenter?.openAboutAppScreen()
    }
    
    @objc func showAllCitiesButtonClick() {
        presenter?.openSelectCityScreen()
    }
    
    @objc func exitButtonClick() {
        presenter?.exit()
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setCountries() {
        configureSelectCountyPickerView(textField: mainView.selectCountryTextField, pickerView: mainView.selectCountryPickerView)
        
        if presenter?.getCountriesCount() ?? 0 > 0 && mainView.selectCountryTextField.text?.isEmpty ?? true {
            mainView.selectCountryTextField.text = presenter?.getCountry(countryId: SettingsService.shared.settings.countryId)?.title
            if let selectedRow = presenter?.getCountryRow(countryId: SettingsService.shared.settings.countryId) {
                self.selectedRow = selectedRow
                mainView.selectCountryPickerView.selectRow(selectedRow, inComponent: 0, animated: true)
            }
        }
        
        mainView.selectMainScreenAppButtonsStackView.arrangedSubviews.forEach { subview in
            if let button = subview as? UIButton {
                button.isSelected = button.tag == SettingsService.shared.settings.mainScreenApp.rawValue
            }
        }
    }
    
    func collectionViewReloadData() {
        mainView.citiesCollectionView.reloadData()
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
        guard let selectedRow = selectedRow, let countCities = presenter?.getCitiesCount(selectedCountryRow: selectedRow) else {
            return 0
        }
        
        let rows = Int(collectionView.bounds.height.rounded(.down)) / 58
        let maxElements = countElementsInRowCV * rows
        
        return countCities < maxElements ? countCities : maxElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? SettingsCityCollectionViewCell else {
            let cell = SettingsCityCollectionViewCell()
            if let selectedRow = selectedRow {
                presenter?.configureCell(cell, row: indexPath.row, selectedCountryRow: selectedRow)
            }
            cell.delegate = presenter
            return cell
        }
        
        if let selectedRow = selectedRow {
            presenter?.configureCell(cell, row: indexPath.row, selectedCountryRow: selectedRow)
        }
        cell.delegate = presenter
        
        return cell
    }
}

extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let width: CGFloat = collectionViewWidth / CGFloat(countElementsInRowCV) - (12 * CGFloat(countElementsInRowCV - 1))
        return CGSize(width: width, height: 50)
    }
}
