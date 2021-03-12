//
//  ChallengeArrowTableViewCell.swift
//  Globe Us
//
//  Created by Karim on 11.03.2021.
//

import UIKit

class ChallengeArrowTableViewCell: UITableViewCell {
    
    private(set) lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "arrow_right")
        imageView.clipsToBounds = true
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(at row: Int) {
        if row % 2 == 0 {
            arrowImageView.image = UIImage(named: "arrow_left")
        } else {
            arrowImageView.image = UIImage(named: "arrow_right")
        }
        backgroundColor = .clear
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(arrowImageView)
    }
    
    private func makeConstraints() {
        arrowImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(70)
            make.centerY.equalToSuperview()
        }
    }

}
