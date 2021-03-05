//
//  WorkModeCollectionViewCell.swift
//  Globe Us
//
//  Created by Karim on 01.03.2021.
//

import UIKit

class WorkModeCollectionViewCell: UICollectionViewCell {
    
    private(set) lazy var view: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private(set) lazy var cloudsView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .blue
        return view
    }()
    
    private(set) lazy var challengeView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(red: 1, green: 0.671, blue: 0.173, alpha: 1)
        return view
    }()
    
    private(set) lazy var locImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loc")
        return imageView
    }()
    
    private(set) lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Санкт-Петербург"
        label.font = UIFont(name: "Geometria-Medium", size: 18)
        label.textColor = UIColor(red: 0.077, green: 0.073, blue: 0.237, alpha: 1)
        return label
    }()
    
    private(set) lazy var challangeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Челлендж"
        label.textColor = .white
        label.font = UIFont(name: "Geometria-Medium", size: 18)
        return label
    }()
    
    private(set) lazy var challangeSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Точки Силы Города"
        label.textColor = UIColor(red: 0.537, green: 0.373, blue: 0.204, alpha: 1)
        label.font = UIFont(name: "Geometria-Medium", size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(view)
        
        view.addSubview(cloudsView)
        cloudsView.addSubview(locImageView)
        cloudsView.addSubview(cityNameLabel)
        
        view.addSubview(challengeView)
        challengeView.addSubview(challangeTitleLabel)
        challengeView.addSubview(challangeSubTitleLabel)
    }
    
    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        cloudsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        locImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(16)
            make.leading.equalToSuperview().offset(16)
        }
        cityNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(locImageView.snp.right).offset(6)
        }
        challengeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        challangeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(13)
        }
        challangeSubTitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(13)
        }
    }
}
