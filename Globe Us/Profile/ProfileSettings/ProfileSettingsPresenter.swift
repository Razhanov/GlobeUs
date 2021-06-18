//
//  ProfileSettingsPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 30.05.2021.
//

import Foundation
import UIKit

protocol ProfileSettingsViewProtocol: AnyObject {
    func setData(_ data: ProfileResponse)
}

protocol ProfileSettingsPresenter {
    func viewDidLoad()
    func backAction()
    func doneAction(firstName: String, lastName: String, gender: Int, homeCity: String, birthday: String)
}

final class ProfileSettingsPresenterImplementation: ProfileSettingsPresenter {
    
    fileprivate weak var view: ProfileSettingsViewProtocol?
    fileprivate weak var navigationController: UINavigationController?
    
    private var data: ProfileResponse? {
        didSet {
            if let data = data {
                view?.setData(data)
            }
        }
    }
    
    init(view: ProfileSettingsViewProtocol, navigationController: UINavigationController?) {
        self.view = view
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        ProfileService.getProfile { [weak self] response in
            switch response {
            case .success(let result):
                self?.data = result.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func doneAction(firstName: String, lastName: String, gender: Int, homeCity: String, birthday: String) {
        ProfileService.changeProfile(firstName: firstName, lastName: lastName, gender: gender, homeCity: homeCity, birthday: birthday)
        
        navigationController?.popViewController(animated: true)
    }
}
