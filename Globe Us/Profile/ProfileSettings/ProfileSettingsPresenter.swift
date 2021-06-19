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
    weak var mainCoordinator: MainCoordinator?
    
    private var data: ProfileResponse? {
        didSet {
            if let data = data {
                view?.setData(data)
            }
        }
    }
    
    init(view: ProfileSettingsViewProtocol) {
        self.view = view
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
        mainCoordinator?.openPreviousViewController()
    }
    
    func doneAction(firstName: String, lastName: String, gender: Int, homeCity: String, birthday: String) {
        ProfileService.changeProfile(firstName: firstName, lastName: lastName, gender: gender, targetPlace: homeCity, birthday: birthday) { [weak self] response in
            switch response {
            case .success():
                self?.mainCoordinator?.openPreviousViewController()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
