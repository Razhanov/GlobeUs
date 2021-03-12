//
//  ChallengeDetailInfoView.swift
//  Globe Us
//
//  Created by Karim on 12.03.2021.
//

import UIKit

class ChallengeDetailInfoView: UIView {

    private(set) lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var challengeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geometria-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0.077, green: 0.073, blue: 0.237, alpha: 1)
        return label
    }()
    
    private(set) lazy var locLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private(set) lazy var navButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nav"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private(set) lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor(red: 0.077, green: 0.073, blue: 0.237, alpha: 1)
        textView.font = UIFont(name: "Geometria-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular)
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return textView
    }()
    
    func display(place: Place) {
        challengeImageView.loadWithAlamofire(urlStringFull: place.images.first ?? "")
        titleLabel.text = place.title
        descriptionTextView.text = place.description
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(view)
        view.addSubview(challengeImageView)
        view.addSubview(titleLabel)
        view.addSubview(locLabel)
        view.addSubview(navButton)
        view.addSubview(descriptionTextView)
    }
    
    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        challengeImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(170)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(challengeImageView.snp.bottom).offset(15)
        }
        locLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        navButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(challengeImageView.snp.bottom).offset(12)
            make.width.height.equalTo(40)
        }
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(navButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().inset(22)
        }
    }
}
