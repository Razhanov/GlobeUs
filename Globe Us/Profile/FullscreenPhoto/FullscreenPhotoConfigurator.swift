//
//  FullscreenPhotoConfigurator.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import UIKit

protocol FullscreenPhotoConfigurator {
    func configure(viewController: FullscreenPhotoViewController, urlImage: String)
}

final class FullscreenPhotoConfiguratorImplementation : FullscreenPhotoConfigurator {
    func configure(viewController: FullscreenPhotoViewController, urlImage: String) {
        let presenter = FullscreenPhotoPresenterImplementation(view: viewController, urlImage: urlImage)
        viewController.presenter = presenter
    }
}
