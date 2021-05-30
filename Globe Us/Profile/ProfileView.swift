//
//  ProfileView.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import UIKit

final class ProfileView: UIView {
    private let photoSize: CGFloat = 66
    
    var bannerHeight: CGFloat {
        bounds.height / 4
    }
    
    private(set) lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(iconNamed: .bannerImage)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = photoSize / 2
        return imageView
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var subscriptionView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(colorNamed: .mainColor).cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private(set) lazy var subscriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(colorNamed: .mainColor)
        return label
    }()
    
    private(set) lazy var userSettingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .userSettingsIcon), for: .normal)
        return button
    }()
    
    private(set) lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .settingsIcon), for: .normal)
        return button
    }()
    
    private(set) lazy var metricsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private(set) lazy var countPhotoContainer: UIView = makeMetricsContainer()
    
    private(set) lazy var countPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(iconNamed: .photoCameraIcon)
        return imageView
    }()
    
    private(set) lazy var countPhotoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(colorNamed: .secondaryTextColor)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var stepsContainer: UIView = makeMetricsContainer()
    
    private(set) lazy var stepsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(iconNamed: .stepIcon)
        return imageView
    }()
    
    private(set) lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.text = "12300/9000"
        label.textColor = UIColor(colorNamed: .secondaryTextColor)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var ratingContainer: UIView = makeMetricsContainer()
    
    private(set) lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(iconNamed: .starIcon)
        return imageView
    }()
    
    private(set) lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(colorNamed: .secondaryTextColor)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private(set) lazy var allPhotoButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Все фото", for: .normal)
        button.isSelected = true
        button.tag = 0
        button.layer.cornerRadius = 10
        return button
    }()
    
    private(set) lazy var fromGlobeUsPhotoButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Globe Us!", for: .normal)
        button.isSelected = false
        button.tag = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    private(set) lazy var fromGalleryPhotoButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("с телефона", for: .normal)
        button.isSelected = false
        button.tag = 2
        button.layer.cornerRadius = 10
        return button
    }()
    
    private(set) lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initilizate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeMetricsContainer() -> UIView {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(colorNamed: .secondaryColor).cgColor
        return view
    }
    
    func setData(_ data: ProfileResponsce) {
        collectionView.reloadData()
        photoImageView.loadWithAlamofire(urlStringFull: data.photoURL)
        nameLabel.text = "\(data.firstName)\n\(data.lastName)"
        subscriptionLabel.text = data.subscription
        countPhotoLabel.text = data.countPhoto.description
        ratingLabel.text = String(format: "%.1f", data.rating)
    }
    
    func updateBannerView(height: CGFloat) {
        if height == 0 {
            photoImageView.snp.remakeConstraints { make in
                make.top.equalTo(bannerImageView.snp.bottom).offset(24)
                make.leading.equalTo(safeAreaLayoutGuide).inset(16)
                make.size.equalTo(photoSize)
            }
        }
        
        bannerImageView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
    }
    
    private func initilizate() {
        backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(bannerImageView)
        addSubview(photoImageView)
        addSubview(nameLabel)
        subscriptionView.addSubview(subscriptionLabel)
        addSubview(subscriptionView)
        addSubview(userSettingsButton)
        addSubview(settingsButton)
        
        countPhotoContainer.addSubview(countPhotoImageView)
        countPhotoContainer.addSubview(countPhotoLabel)
        
        stepsContainer.addSubview(stepsImageView)
        stepsContainer.addSubview(stepsLabel)
        
        ratingContainer.addSubview(ratingImageView)
        ratingContainer.addSubview(ratingLabel)
        
        metricsStackView.addArrangedSubview(countPhotoContainer)
        metricsStackView.addArrangedSubview(stepsContainer)
        metricsStackView.addArrangedSubview(ratingContainer)
        
        addSubview(metricsStackView)
        
        buttonsStackView.addArrangedSubview(allPhotoButton)
        buttonsStackView.addArrangedSubview(fromGlobeUsPhotoButton)
        buttonsStackView.addArrangedSubview(fromGalleryPhotoButton)
        
        addSubview(buttonsStackView)
        
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(bannerHeight)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.size.equalTo(photoSize)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView).offset(4)
            make.leading.equalTo(photoImageView.snp.trailing).offset(16)
        }
        
        subscriptionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
        
        subscriptionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        userSettingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.leading.greaterThanOrEqualTo(subscriptionView.snp.trailing).offset(8)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(userSettingsButton)
            make.leading.equalTo(userSettingsButton.snp.trailing).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        metricsStackView.snp.makeConstraints { make in
            make.top.equalTo(subscriptionView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        countPhotoImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
        
        countPhotoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(countPhotoImageView)
            make.leading.equalTo(countPhotoImageView.snp.trailing).offset(6)
            make.centerX.equalToSuperview().offset(15)
        }
        
        stepsImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
        
        stepsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(stepsImageView)
            make.leading.equalTo(stepsImageView.snp.trailing).offset(6)
            make.centerX.equalToSuperview().offset(15)
        }
        
        ratingImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingImageView)
            make.leading.equalTo(ratingImageView.snp.trailing).offset(6)
            make.centerX.equalToSuperview().offset(15)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(metricsStackView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
