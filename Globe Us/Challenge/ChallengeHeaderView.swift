//
//  ChallengeHeaderView.swift
//  Globe Us
//
//  Created by Karim on 11.03.2021.
//

import UIKit

class ChallengeHeaderView: UIView {

    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.white
        ]
        let attTitle = NSAttributedString(string: "Челлендж", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        return button
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geometria-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .medium)
        label.text = "Точки Силы Города"
        label.textColor = UIColor(red: 0.537, green: 0.373, blue: 0.204, alpha: 1)
        return label
    }()
    
    private(set) lazy var detailButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: UIColor(red: 0.283, green: 0.283, blue: 0.283, alpha: 1)
        ]
        let attTitle = NSAttributedString(string: "Подробно", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 1, green: 0.671, blue: 0.173, alpha: 1).cgColor
        return button
    }()
    
    private(set) lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Group 2080")
        imageView.contentMode = .center
        return imageView
    }()
    
    private(set) lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Geometria-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .medium)
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
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(detailButton)
        addSubview(headerImageView)
        addSubview(detailLabel)
    }
    
    private func makeConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(13)
            make.height.equalTo(40)
            make.width.equalTo(122)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom)
            make.leading.equalToSuperview().offset(52)
        }
        detailButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().offset(49)
            make.height.equalTo(28)
            make.width.equalTo(122)
        }
        headerImageView.snp.makeConstraints { (make) in
            make.trailing.centerY.equalToSuperview()
            make.left.equalTo(detailButton.snp.right)
            make.top.bottom.equalToSuperview()
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(52)
            make.bottom.equalTo(detailButton.snp.top)
        }
    }
}
