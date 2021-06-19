//
//  FullscreenPhotoViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import UIKit

final class FullscreenPhotoViewController: UIViewController {
    var presenter: FullscreenPhotoPresenter?
    
    private lazy var mainView: FullscreenPhotoView = {
        let view = FullscreenPhotoView()
        
        view.blackoutBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    @objc private func dismissView() {
        presenter?.backAction()
    }
}

extension FullscreenPhotoViewController: FullscreenPhotoViewProtocol {
    func setImage(url: String) {
        mainView.imageView.loadWithAlamofire(urlStringFull: url)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
