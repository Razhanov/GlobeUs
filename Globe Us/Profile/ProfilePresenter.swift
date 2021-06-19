//
//  ProfilePresenter.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import Foundation
import UIKit

protocol ProfileViewProtocol: AnyObject {
    var view: UIView! { get }
    
    func setData(_ data: ProfileResponse)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

protocol ProfilePresenter {
    func viewDidLoad()
    func viewWillAppear()
    func getCountSection() -> Int
    func getCountCellOnSection(section: Int) -> Int
    func configureHeader(_ header: ProfileHeaderCollectionReusableView, section: Int)
    func configureCell(_ cell: ProfileCollectionViewCell, indexPath: IndexPath)
    func sharePhoto(_ indexPath: IndexPath)
    func deletePhoto(indexPath: IndexPath, collectionView: UICollectionView)
    func openProfileSettingsScreen()
    func openSettingsScreen()
    func openImage(indexPath: IndexPath)
}

final class ProfilePresenterImplementation: ProfilePresenter {
    
    weak var viewController: UIViewController?
    fileprivate weak var view: ProfileViewProtocol?
    fileprivate weak var navigationController: UINavigationController?
    private var data: ProfileResponse? {
        didSet {
            if let data = data {
                view?.setData(data)
            }
        }
    }
    
    init(view: ProfileViewProtocol, navigationController: UINavigationController?) {
        self.view = view
        self.navigationController = navigationController
    }
    
    func viewWillAppear() {
        ProfileService.getProfile { [weak self] response in
            switch response {
            case .success(let result):
                self?.data = result.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
    }
    
    func sharePhoto(_ indexPath: IndexPath) {
        guard let data = data, indexPath.section < data.photos.count else { return }
        guard indexPath.row < data.photos[indexPath.section].photosURL.count else { return }
        guard let imageURL = URL(string: data.photos[indexPath.section].photosURL[indexPath.row]) else { return }
        
        let activityController = UIActivityViewController(activityItems: [imageURL], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = view?.view
        view?.present(activityController, animated: true, completion: nil)
    }
    
    func deletePhoto(indexPath: IndexPath, collectionView: UICollectionView) {
        guard indexPath.section < data?.photos.count ?? 0 else { return }
        guard indexPath.row < data?.photos[indexPath.section].photosURL.count ?? 0 else { return }
        
        data?.photos[indexPath.section].photosURL.remove(at: indexPath.row)
    }
    
    func getCountSection() -> Int {
        data?.photos.count ?? 0
    }
    
    func getCountCellOnSection(section: Int) -> Int {
        guard section < data?.photos.count ?? 0 else {
            return 0
        }
        
        return data?.photos[section].photosURL.count ?? 0
    }
    
    func configureHeader(_ header: ProfileHeaderCollectionReusableView, section: Int) {
        guard let data = data, section < data.photos.count else {
            return
        }
        
        header.setCityName(data.photos[section].city)
    }
    
    func configureCell(_ cell: ProfileCollectionViewCell, indexPath: IndexPath) {
        guard let data = data, indexPath.section < data.photos.count else {
            return
        }
        
        guard indexPath.row < data.photos[indexPath.section].photosURL.count else {
            return
        }
        
        cell.loadPhoto(data.photos[indexPath.section].photosURL[indexPath.row])
    }
    
    func openProfileSettingsScreen() {
        let profileSettingsVC = ProfileSettingsViewController()
        
        navigationController?.pushViewController(profileSettingsVC, animated: true)
    }
    
    func openSettingsScreen() {
        let settingsVC = SettingsViewController()
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func openImage(indexPath: IndexPath) {
        guard let data = data, indexPath.section < data.photos.count else {
            return
        }
        
        guard indexPath.row < data.photos[indexPath.section].photosURL.count else {
            return
        }
        
        let fullscreenImageVC = FullscreenPhotoViewController()
        
        let configurator = FullscreenPhotoConfiguratorImplementation()
        configurator.configure(viewController: fullscreenImageVC, urlImage: data.photos[indexPath.section].photosURL[indexPath.row])
        
        viewController?.present(fullscreenImageVC, animated: true, completion: nil)
    }
}
