//
// Created by Karim on 10.03.2021.
//

import UIKit

class ChallengeInfoView: UIView {
    private(set) lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#14133D")
        return view
    }()

    private(set) lazy var startButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Medium", size: 16) ?? .systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor(hexString: "#FFAB2C")
        ]
        let attTitle = NSAttributedString(string: "Пройти Челлендж!", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        button.layer.borderColor = UIColor(hexString: "#FFAB2C").cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    private(set) lazy var infoButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Regular", size: 22) ?? .systemFont(ofSize: 22, weight: .regular),
            .foregroundColor: UIColor(hexString: "#FFAB2C")
        ]
        let attTitle = NSAttributedString(string: "?", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        button.layer.borderColor = UIColor(hexString: "#FFAB2C").cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "В этом городе есть,\nчто посмотреть!\nПогнали! ⭐"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Geometria-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private(set) lazy var challengeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "challenge_info")//?.aspectFitImage(inRect: CGRect(origin: .zero, size: CGSize(width: 280, height: 280)))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(view)
        view.addSubview(startButton)
        view.addSubview(infoButton)
        view.addSubview(titleLabel)
        view.addSubview(challengeImageView)
    }

    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(54)
            make.leading.equalToSuperview().offset(50)
            make.height.equalTo(40)
        }
        infoButton.snp.makeConstraints { (make) in
            make.left.equalTo(startButton.snp.right).offset(7)
            make.width.height.equalTo(40)
            make.trailing.equalToSuperview().inset(47)
            make.centerY.equalTo(startButton.snp.centerY)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(60)
            make.bottom.equalTo(startButton.snp.top).offset(-36)
        }
        challengeImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.bottom)
        }
    }
}
