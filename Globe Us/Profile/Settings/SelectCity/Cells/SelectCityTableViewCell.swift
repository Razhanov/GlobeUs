//
//  SelectCityTableViewCell.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import UIKit

class SelectCityTableViewCell: UITableViewCell {
    var city: City?
    
    weak var delegate: LoadCityDelegate?
    
    private var isLoad: Bool = false {
        didSet {
            loadButton.setImage(UIImage(iconNamed: isLoad ? .downloadDoneIcon : .downloadIcon), for: .normal)
        }
    }
    
    private let photoImageViewSize: CGSize = .init(width: 50, height: 50)
    private let buttonSize: CGSize = .init(width: 24, height: 24)
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = getCornerRadius(size: photoImageViewSize)
        return imageView
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(colorNamed: .textColor)
        return label
    }()
    
    private(set) lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(iconNamed: .downloadIcon), for: .normal)
        return button
    }()
    
    private func getCornerRadius(size: CGSize) -> CGFloat {
        if size.width == size.height {
            return size.width / 2
        } else {
            return max(size.width, size.height) / 2
        }
    }
    
    func setData(city: City, isLoad: Bool) {
        self.city = city
        
        if let url = city.images.first, url != nil {
            photoImageView.loadWithAlamofire(urlStringFull: url!)
        }
        
        nameLabel.text = city.title
        
        self.isLoad = isLoad
        
        loadButton.addTarget(self, action: #selector(clickLoadButton), for: .touchUpInside)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initilizate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        loadButton.setImage(UIImage(iconNamed: .downloadIcon), for: .normal)
    }
    
    private func initilizate() {
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
        
        addSubviews()
        setupConstraints()
        configureEvents()
    }
    
    private func addSubviews() {
        addSubview(photoImageView)
        addSubview(nameLabel)
        addSubview(loadButton)
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(photoImageViewSize)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(photoImageView)
            make.leading.equalTo(photoImageView.snp.trailing).offset(12)
        }
        
        loadButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(buttonSize)
        }
    }
    
    private func configureEvents() {
        loadButton.addTarget(self, action: #selector(clickLoadButton), for: .touchUpInside)
    }
    
    @objc private func clickLoadButton() {
        guard let city = city else {
            return
        }
        
        delegate?.loadCity(city) { [weak self] in
            self?.isLoad = true
        }
    }
}
