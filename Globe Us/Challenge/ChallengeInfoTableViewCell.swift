//
//  ChallengeInfoTableViewCell.swift
//  Globe Us
//
//  Created by Karim on 11.03.2021.
//

import UIKit

class ChallengeInfoTableViewCell: UITableViewCell {
    
    private(set) lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var numberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        return view
    }()
    
    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var challengeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(hexString: "#FFAB2C").cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        view.removeFromSuperview()
        view.snp.removeConstraints()
        numberView.snp.removeConstraints()
        numberLabel.snp.removeConstraints()
        challengeImageView.snp.removeConstraints()
        titleLabel.snp.removeConstraints()
    }
    
    func set(place: Place, for row: Int) {
        backgroundColor = .clear
        setView(on: row)
        titleLabel.text = place.title
        numberLabel.text = "\(row + 1)"
        challengeImageView.loadWithAlamofire(urlStringFull: place.images.first ?? "")
    }
    
    private func setView(on row: Int) {
        addSuvviews()
        if row % 2 == 0 {
            makeLeftAlignConstraints()
            titleLabel.textAlignment = .left
        } else {
            makeRightAlignConstraints()
            titleLabel.textAlignment = .right
        }
    }
    
    private func addSuvviews() {
        addSubview(view)
        view.addSubview(numberView)
        numberView.addSubview(numberLabel)
        view.addSubview(challengeImageView)
        view.addSubview(titleLabel)
        view.bringSubviewToFront(numberView)
    }
    
    private func makeLeftAlignConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        numberView.snp.makeConstraints { (make) in
            make.height.width.equalTo(44)
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalToSuperview()
        }
        numberLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        challengeImageView.snp.makeConstraints { (make) in
            make.left.equalTo(numberView.snp.right).offset(-12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(64)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(challengeImageView.snp.right).offset(18)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(45)
        }
    }
    
    private func makeRightAlignConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        numberView.snp.makeConstraints { (make) in
            make.height.width.equalTo(44)
            make.trailing.equalToSuperview().inset(45)
            make.centerY.equalToSuperview()
        }
        numberLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        challengeImageView.snp.makeConstraints { (make) in
            make.right.equalTo(numberView.snp.left).inset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(64)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(challengeImageView.snp.left).inset(-18)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(45)
        }
    }

}
