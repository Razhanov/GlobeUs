//
//  ProfileCollectionViewCell.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initilizate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadPhoto(_ url: String) {
        photoImageView.loadWithAlamofire(urlStringFull: url)
    }
    
    private func initilizate() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
