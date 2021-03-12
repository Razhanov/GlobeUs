//
//  AboutChallengeView.swift
//  Globe Us
//
//  Created by Karim on 12.03.2021.
//

import UIKit

class AboutChallengeView: UIView {

    private(set) lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var aboutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "about_detail")
        return imageView
    }()
    
    private(set) lazy var challengeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Проходя челлендж, ты получаешь основные баллы за каждую Точку Силы, а также дополнительные – за факт прохождения Челленджа полностью. 💪 Эти баллы влияют на твой рейтинг и помогают получить скидку на продление подписок! Оставайся с Globe Us! 🌎"
        label.font = UIFont(name: "Geometria-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0.077, green: 0.073, blue: 0.237, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var aboutTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "В этом городе есть, что посмотреть! Погнали! ⭐"
        label.textColor = UIColor(red: 0.077, green: 0.073, blue: 0.237, alpha: 1)
        label.font = UIFont(name: "Geometria-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var startChallengeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#FFAB2C")
        button.layer.cornerRadius = 10
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor(red: 0.077, green: 0.073, blue: 0.237, alpha: 1)
        ]
        let attTitle = NSAttributedString(string: "Пройти Челлендж!", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        return button
    }()
    
    private(set) lazy var moreInfoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#FFAB2C")
        button.layer.cornerRadius = 10
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.white
        ]
        let attTitle = NSAttributedString(string: "Узнать больше", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        return button
    }()
    
    private(set) lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#E8EBF1")
        button.layer.cornerRadius = 10
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Regular", size: 18) ?? .systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor(red: 0.486, green: 0.523, blue: 0.621, alpha: 1)
        ]
        let attTitle = NSAttributedString(string: "Закрыть", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        return button
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
        view.addSubview(aboutImageView)
        view.addSubview(challengeInfoLabel)
        view.addSubview(aboutTitleLabel)
        view.addSubview(startChallengeButton)
        view.addSubview(moreInfoButton)
        view.addSubview(closeButton)
    }
    
    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        aboutImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(128)
        }
        challengeInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(aboutImageView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        closeButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(18)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(48)
        }
        moreInfoButton.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(18)
            make.bottom.equalTo(closeButton.snp.top).inset(-7)
        }
        startChallengeButton.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(18)
            make.bottom.equalTo(moreInfoButton.snp.top).inset(-7)
        }
        aboutTitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(startChallengeButton.snp.top).inset(14)
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(challengeInfoLabel.snp.bottom).offset(16)
        }
    }

}
