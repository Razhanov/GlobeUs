//
//  ProfileViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import UIKit

enum ProfilePhotoSource: Int {
    case all, globeUs, gallery
}

final class ProfileViewController: UIViewController {
    
    var configurator = ProfileConfiguratorImplementation()
    var presenter: ProfilePresenter?
    
    private let headerReuseIdentifier: String = "ProfileHeaderCollectionReusableView"
    private let cellReuseIdentifier: String = "ProfileCollectionViewCell"
    private var photoSource: ProfilePhotoSource = .all
    
    private lazy var mainView: ProfileView = {
        let view = ProfileView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        view.collectionView.register(ProfileHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        view.allPhotoButton.addTarget(self, action: #selector(changePhotoSourceTapped), for: .touchUpInside)
        view.fromGlobeUsPhotoButton.addTarget(self, action: #selector(changePhotoSourceTapped), for: .touchUpInside)
        view.fromGalleryPhotoButton.addTarget(self, action: #selector(changePhotoSourceTapped), for: .touchUpInside)
        view.userSettingsButton.addTarget(self, action: #selector(clickUserSettingsButton), for: .touchUpInside)
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        DispatchQueue.main.async {
            self.scrollViewDidScroll(self.mainView.collectionView)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(viewController: self)
        presenter?.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.async {
            self.scrollViewDidScroll(self.mainView.collectionView)
        }
        mainView.collectionView.reloadData()
    }
    
    @objc private func changePhotoSourceTapped(_ sender : UIButton){
        photoSource = ProfilePhotoSource(rawValue: sender.tag) ?? .all
        
        switch photoSource {
        case .all:
            mainView.allPhotoButton.isSelected = true
            mainView.fromGlobeUsPhotoButton.isSelected = false
            mainView.fromGalleryPhotoButton.isSelected = false
        case .globeUs:
            mainView.allPhotoButton.isSelected = false
            mainView.fromGlobeUsPhotoButton.isSelected = true
            mainView.fromGalleryPhotoButton.isSelected = false
        case .gallery:
            mainView.allPhotoButton.isSelected = false
            mainView.fromGlobeUsPhotoButton.isSelected = false
            mainView.fromGalleryPhotoButton.isSelected = true
        }
    }
    
    @objc private func clickUserSettingsButton() {
        presenter?.openProfileSettingsScreen()
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func setData(_ data: ProfileResponse) {
        mainView.setData(data)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.getCountSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getCountCellOnSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: headerReuseIdentifier,
                    for: indexPath) as? ProfileHeaderCollectionReusableView
            else {
                let headerView = ProfileHeaderCollectionReusableView()
                presenter?.configureHeader(headerView, section: indexPath.section)
                return headerView
            }
            
            presenter?.configureHeader(headerView, section: indexPath.section)
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? ProfileCollectionViewCell else {
            let cell = ProfileCollectionViewCell()
            presenter?.configureCell(cell, indexPath: indexPath)
            return cell
        }
        
        presenter?.configureCell(cell, indexPath: indexPath)
        
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bannerHeight = mainView.bannerHeight
        let y = bannerHeight  - (scrollView.contentOffset.y / 2)
        let height = min(max(y, 0), bannerHeight)
        
        mainView.updateBannerView(height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        var width: CGFloat!
        if collectionViewWidth / 5 > 110 {
            if collectionViewWidth / 7 > 110 {
                width = collectionViewWidth / 7 - 12
            } else {
                width = collectionViewWidth / 5 - 12
            }
        } else {
            width = collectionViewWidth / 3 - 12
        }
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: presenter?.getCountCellOnSection(section: section) ?? 0 > 0 ? 40 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { [weak self] _ in
                guard let self = self else { return UIMenu(title: "", children: []) }
                let children: [UIMenuElement] = [self.makeShareAction(indexPath: indexPath), self.makeRemoveAction(collectionView: collectionView, indexPath: indexPath)]
                return UIMenu(title: "", children: children)
            })
    }
    
    private func makeShareAction(indexPath: IndexPath) -> UIAction {
        let shareImage = UIImage(systemName: "square.and.arrow.up")
        
        return UIAction(
            title: "Поделиться",
            image: shareImage,
            identifier: nil) { [weak self] _ in
            self?.presenter?.sharePhoto(indexPath)
        }
    }
    
    private func makeRemoveAction(collectionView: UICollectionView, indexPath: IndexPath) -> UIAction {
        let deleteImage = UIImage(systemName: "delete.left")
        
        return UIAction(
            title: "Удалить",
            image: deleteImage,
            identifier: nil,
            attributes: .destructive) { [weak self] _ in
            self?.showConfirmDeleteAlert { [weak self] in
                self?.presenter?.deletePhoto(indexPath: indexPath, collectionView: collectionView)
            }
        }
    }
}
