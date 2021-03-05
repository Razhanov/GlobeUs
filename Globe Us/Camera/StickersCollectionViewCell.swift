//
//  StickersCollectionViewCell.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import UIKit

class StickersCollectionViewCell: UICollectionViewCell {
    
    private(set) lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private(set) lazy var stickerImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func update(with place: Place?) {
        stickerImageView.loadWithAlamofire(urlStringFull: place?.images.first ?? "")
    }
    
    func update(with cloud: CloudData?) {
        stickerImageView.loadWithAlamofire(urlStringFull: cloud?.squareImage ?? "")
    }
    
    //MARK: - Private methods
    private func addSubviews() {
        addSubview(view)
        view.addSubview(stickerImageView)
    }
    
    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        stickerImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
