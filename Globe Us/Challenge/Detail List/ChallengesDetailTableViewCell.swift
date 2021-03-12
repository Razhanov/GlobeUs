//
//  ChallengesDetailTableViewCell.swift
//  Globe Us
//
//  Created by Karim on 12.03.2021.
//

import UIKit

class ChallengesDetailTableViewCell: UITableViewCell {

    private(set) lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geometria-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var locLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private(set) lazy var navigationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nav"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private(set) lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.font = UIFont(name: "Geometria-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular)
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return textView
    }()
    
    private(set) lazy var detailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#FFAB2C")
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 1, green: 0.671, blue: 0.173, alpha: 1).cgColor
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Medium", size: 14) ?? .systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor(red: 0.078, green: 0.075, blue: 0.239, alpha: 1)
        ]
        let attTitle = NSAttributedString(string: "Подробно", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        return button
    }()
    
    func display(place: Place) {
        backgroundColor = .clear
        selectionStyle = .none
        placeImageView.loadWithAlamofire(urlStringFull: place.images.first ?? "")
        titleLabel.text = place.title
        detailTextView.text = place.description
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(placeImageView)
        addSubview(titleLabel)
        addSubview(locLabel)
        addSubview(navigationButton)
        addSubview(detailTextView)
        addSubview(detailButton)
    }
    
    private func makeConstraints() {
        placeImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(21)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(170)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(21)
            make.top.equalTo(placeImageView.snp.bottom).offset(15)
        }
        locLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(21)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        navigationButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.right.equalTo(placeImageView.snp.right)
            make.top.equalTo(placeImageView.snp.bottom).offset(7)
        }
        detailTextView.snp.makeConstraints { (make) in
            make.top.equalTo(locLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        detailButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(32)
            make.bottom.equalToSuperview()
            make.top.equalTo(detailTextView.snp.bottom).offset(15)
        }
    }
}
