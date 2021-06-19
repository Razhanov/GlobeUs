//
//  FullscreenPhotoPresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import Foundation
import UIKit

protocol FullscreenPhotoViewProtocol: AnyObject {
    func setImage(url: String)
    func dismiss()
}

protocol FullscreenPhotoPresenter {
    func viewDidLoad()
    func backAction()
}

final class FullscreenPhotoPresenterImplementation: FullscreenPhotoPresenter {
    
    fileprivate weak var view: FullscreenPhotoViewProtocol?
    
    fileprivate let urlImage: String
    
    init(view: FullscreenPhotoViewProtocol, urlImage: String) {
        self.view = view
        self.urlImage = urlImage
    }
    
    func viewDidLoad() {
        view?.setImage(url: urlImage)
    }
    
    func backAction() {
        view?.dismiss()
    }
}
