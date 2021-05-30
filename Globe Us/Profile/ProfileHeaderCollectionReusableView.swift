//
//  ProfileHeaderCollectionReusableView.swift
//  Globe Us
//
//  Created by Михаил Беленко on 30.05.2021.
//

import UIKit

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    private(set) lazy var pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(iconNamed: .pinIcon)
        return imageView
    }()
    
    private(set) lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var nextLabel: UILabel = {
        let label = UILabel()
        label.text = "На карте"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .grayColor)
        return label
    }()
    
    private(set) lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .nextIcon), for: .normal)
        return button
    }()
    
    func setCityName(_ name: String) {
        cityNameLabel.text = name
    }
    
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
        addSubview(pinImageView)
        addSubview(cityNameLabel)
        addSubview(nextLabel)
        addSubview(nextButton)
    }
    
    private func setupConstraints() {
        pinImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(safeAreaLayoutGuide).inset(12)
            make.size.equalTo(24)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pinImageView)
            make.leading.equalTo(pinImageView.snp.trailing).offset(4)
        }
        
        nextLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(cityNameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(pinImageView)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(nextLabel.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaInsets).inset(20)
            make.centerY.equalTo(pinImageView)
        }
    }
}
