//
//  ChangePasswordPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import Foundation
import UIKit

protocol ChangePasswordViewProtocol: AnyObject {
}

protocol ChangePasswordPresenter {
    func viewDidLoad()
    func backAction()
    func doneAction(oldPassword: String, newPassword: String)
}

final class ChangePasswordPresenterImplementation: ChangePasswordPresenter {
    
    fileprivate weak var view: ChangePasswordViewProtocol?
    weak var mainCoordinator: MainCoordinator?
    
    init(view: ChangePasswordViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
    }
    
    func backAction() {
        mainCoordinator?.openPreviousViewController()
    }
    
    func doneAction(oldPassword: String, newPassword: String) {
        ProfileService.changePassword(oldPassword: oldPassword, newPassword: newPassword) { [weak self] response in
            switch response {
            case .success():
                self?.mainCoordinator?.openPreviousViewController()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
