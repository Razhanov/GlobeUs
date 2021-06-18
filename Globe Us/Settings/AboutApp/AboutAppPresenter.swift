//
//  AboutAppPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import Foundation
import UIKit

protocol AboutAppViewProtocol: AnyObject {
}

protocol AboutAppPresenter {
    func viewDidLoad()
    func backAction()
    func configureCell(_ cell: AboutAppTableViewCell, row: Int)
}

final class AboutAppPresenterImplementation: AboutAppPresenter {
    
    fileprivate weak var view: AboutAppViewProtocol?
    fileprivate weak var navigationController: UINavigationController?
    
    init(view: AboutAppViewProtocol, navigationController: UINavigationController?) {
        self.view = view
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureCell(_ cell: AboutAppTableViewCell, row: Int) {
        guard let title = AboutAppTableViewCellType(rawValue: row)?.description else {
            return
        }
        
        cell.setTitle(title)
    }
}
