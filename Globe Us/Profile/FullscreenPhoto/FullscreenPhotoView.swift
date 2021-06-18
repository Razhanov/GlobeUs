//
//  FullscreenPhotoView.swift
//  Globe Us
//
//  Created by Михаил Беленко on 19.06.2021.
//

import UIKit

final class FullscreenPhotoView: UIView {
    
    private(set) lazy var blackoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initilizate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initilizate() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(blackoutBackgroundView)
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        blackoutBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(32)
        }
    }
}
